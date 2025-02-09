import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/urils/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/datasoruces/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUpAll(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response(
          'User created successflly',
          201,
        ),
      );

      final methodCall = remoteDataSource.createUser;

      expect(
        methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response(
          'Invalid email address',
          400,
        ),
      );

      final methodCall = remoteDataSource.createUser;

      expect(
          () async => methodCall(
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              ),
          throwsA(const APIException(
              message: 'Invalid email address', statusCode: 400)));

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    test('should return a [List<User>] when the status code  is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
            jsonEncode(
              [tUsers.first.toMap()],
            ),
            200),
      );

      final result = await remoteDataSource.getUsers();
      expect(
        result,
        equals(tUsers),
      );

      verify(() => client.get(Uri.https(
            kBaseUrl,
            kGetUsersEndpoint,
          ))).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200',
        () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response('Server down', 500),
      );

      final methodCall = remoteDataSource.getUsers;

      expect(
        () => methodCall(),
        throwsA(
          const APIException(
            message: 'Server down',
            statusCode: 500,
          ),
        ),
      );

      verify(() => client.get(Uri.https(
            kBaseUrl,
            kGetUsersEndpoint,
          ))).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
