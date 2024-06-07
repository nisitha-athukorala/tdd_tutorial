import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repositoy.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthenticationRepository();
    usecase = GetUsers(repository);
  });

  const tResponse = [
    User.emtpy(),
  ];

  test('Should call [AuthRepo.getUsers] and then return [List<User>]',
      () async {
    // Arrange

    // STUB
    when(() => repository.getUsers()).thenAnswer(
      (invocation) async => const Right(tResponse),
    );

    // Act
    final result = await usecase();

    // Asset
    expect(result, const Right<dynamic, List<User>>(tResponse));

    verify(
      () => repository.getUsers(),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
