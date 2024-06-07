import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.emtpy()
      : this(
          id: '1',
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, name, avatar];

  // bool operator ==(other) {
  //   return identical(this, other) ||
  //       other is User && other.runtimeType == runtimeType && other.id == id;
  // }

  // @override
  // int get hashCode => id.hashCode ^ name.hashCode;
}
