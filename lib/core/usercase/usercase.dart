import 'package:tdd_tutorial/core/urils/typedef.dart';

abstract class UsercaseWithParams<Type, Params> {
  const UsercaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsercaseWitouthParams<Type> {
  const UsercaseWitouthParams();
  ResultFuture<Type> call();
}
