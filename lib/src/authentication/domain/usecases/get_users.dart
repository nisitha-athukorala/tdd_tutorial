import 'package:tdd_tutorial/core/urils/typedef.dart';
import 'package:tdd_tutorial/core/usercase/usercase.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsercaseWitouthParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() => _repository.getUsers();
}
