import 'package:hive/hive.dart';

part 'user_session_model.g.dart';

@HiveType(typeId: 1)
class UserSessionModel extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final DateTime loginTime;

  UserSessionModel({
    required this.uid,
    required this.email,
    required this.loginTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'loginTime': loginTime.toIso8601String(),
    };
  }

  factory UserSessionModel.fromJson(Map<String, dynamic> json) {
    return UserSessionModel(
      uid: json['uid'],
      email: json['email'],
      loginTime: DateTime.parse(json['loginTime']),
    );
  }
}
