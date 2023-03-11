// To parse this JSON data, do
//
//     final dashboardData = dashboardDataFromJson(jsonString);

import 'dart:convert';

DashboardData dashboardDataFromJson(String str) =>
    DashboardData.fromJson(json.decode(str));

String dashboardDataToJson(DashboardData data) => json.encode(data.toJson());

class DashboardData {
  DashboardData({
    required this.data,
    required this.status,
  });

  List<Datum> data;
  bool status;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.courseName,
    required this.description,
    required this.slug,
    required this.scheduleDate,
    this.endDateTime,
    required this.teacherId,
    required this.roomId,
    required this.hostId,
    required this.teacherName,
  });

  String id;
  String courseName;
  String description;
  String slug;
  DateTime scheduleDate;
  DateTime? endDateTime;
  String teacherId;
  String roomId;
  String hostId;
  String teacherName;
  // Teacher teacher;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      courseName: json["course_name"],
      description: json["description"],
      slug: json["slug"],
      //scheduleDate: DateTime.parse(json["schedule_date"]),
      scheduleDate: DateTime.parse(json["schedule_date"]
          .toString()
          .substring(0, json["schedule_date"].toString().length - 1)),
      endDateTime: DateTime.parse(json["schedule_date"]
              .toString()
              .substring(0, json["schedule_date"].toString().length - 1))
          .add(const Duration(hours: 1)),
      teacherId: json["teacherId"],
      roomId: json["roomId"],
      hostId: json["hostId"],
      teacherName: json["teacherName"]
      // teacher: Teacher.fromJson(json["Teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_name": courseName,
        "description": description,
        "slug": slug,
        "schedule_date": scheduleDate.toIso8601String(),
        "teacherId": teacherId,
        "roomId": roomId,
        "hostId": hostId,
        //"Teacher": teacher.toJson(),
      };
}

class Teacher {
  Teacher({
    required this.id,
    required this.userId,
    required this.user,
  });

  String id;
  String userId;
  User user;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        userId: json["userId"],
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "User": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.userType,
  });

  String id;
  String username;
  String email;
  String password;
  String userType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "user_type": userType,
      };
}


// // To parse this JSON data, do
// //
// //     final dashboardData = dashboardDataFromJson(jsonString);

// import 'dart:convert';

// DashboardData dashboardDataFromJson(String str) =>
//     DashboardData.fromJson(json.decode(str));

// String dashboardDataToJson(DashboardData data) => json.encode(data.toJson());

// class DashboardData {
//   DashboardData({
//     required this.data,
//     required this.status,
//   });

//   List<Datum> data;
//   bool status;

//   factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "status": status,
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.courseName,
//     required this.description,
//     required this.slug,
//     required this.scheduleDate,
//     required this.teacherId,
//     required this.roomId,
//     required this.hostId,
//     this.endDateTime,
//     //required this.teacher,
//   });

//   String id;
//   String courseName;
//   String description;
//   String slug;
//   DateTime scheduleDate;
//   DateTime? endDateTime;
//   String teacherId;
//   String roomId;
//   String hostId;
//   // Teacher teacher;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//       id: json["id"],
//       courseName: json["course_name"],
//       description: json["description"],
//       slug: json["slug"],
//       scheduleDate: DateTime.parse(json["schedule_date"]
//           .toString()
//           .substring(0, json["schedule_date"].toString().length - 1)),
//       teacherId: json["teacherId"],
//       roomId: json["roomId"],
//       hostId: json["hostId"],
//       endDateTime: DateTime.parse(json["schedule_date"]).add(Duration(hours: 1))
//       //teacher: Teacher.fromJson(json["Teacher"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "course_name": courseName,
//         "description": description,
//         "slug": slug,
//         "schedule_date": scheduleDate.toIso8601String(),
//         "teacherId": teacherId,
//         "roomId": roomId,
//         "hostId": hostId,
//         // "Teacher": teacher.toJson(),
//       };
// }

// class Teacher {
//   Teacher({
//     required this.id,
//     required this.userId,
//   });

//   String id;
//   String userId;

//   factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
//         id: json["id"],
//         userId: json["userId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//       };
// }
