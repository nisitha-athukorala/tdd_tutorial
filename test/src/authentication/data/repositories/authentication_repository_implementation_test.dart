import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/data/datasoruces/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = APIException(
    message: 'Unknown Error Occured',
    statusCode: 500,
  );

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test(
        'should call the [RemoteDataSource.createUser] and complete sucessfuly'
        'when the call to the remote soruce is successful', () async {
      // arrange
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // asset
      expect(result, equals(const Right(null)));

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should reurn a [APIFailure] when the call to remote source is unsuccessful',
        () async {
      // arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tException);
      // act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // asset
      expect(
        result,
        equals(
          Left(
            APIFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers] and return [List<User>]'
        ' when call to remote source is successful', () async {
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [],
      );

      final result = await repoImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());

      verify(() => remoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should reurn a [APIFailure] when the call to remote source is unsuccessful',
        () async {
      // arrange
      when(
        () => remoteDataSource.getUsers(),
      ).thenThrow(tException);
      // act
      final result = await repoImpl.getUsers();

      // asset
      expect(
        result,
        equals(
          Left(
            APIFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );

      verify(() => remoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
