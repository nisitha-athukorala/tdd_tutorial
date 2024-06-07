import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/urils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subclass of [User] entity', () {
    //Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should resturn a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should resturn a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromJosn(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return [Map] with the right data', () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return [JSON] string with the right data', () {
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar"
      });
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return [UserModel] with different data', () {
      final result = tModel.copyWith(
          id: '2', name: 'Paul', createdAt: 'createdAt', avatar: 'test.avr');

      expect(result.id, equals('2'));
      expect(result.name, equals('Paul'));
      expect(result.createdAt, equals('createdAt'));
      expect(result.avatar, equals('test.avr'));
    });
  });
}
