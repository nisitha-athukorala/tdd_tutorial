import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/urils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasoruces/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSoruce);

  final AuthenticationRemoteDataSource _remoteDataSoruce;

  @override
  RsultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSoruce.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }

    return const Right(null);
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSoruce.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
