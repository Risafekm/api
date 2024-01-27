// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  int status;
  String message;
  List<Datum> data;

  Student({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String studentName;
  String studentClass;
  String teacherName;
  String parentName;
  String parentPh;
  String id;
  String rollNo;

  Datum({
    required this.studentName,
    required this.studentClass,
    required this.teacherName,
    required this.parentName,
    required this.parentPh,
    required this.id,
    required this.rollNo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        studentName: json["student_name"],
        studentClass: json["student_class"],
        teacherName: json["teacher_name"],
        parentName: json["parent_name"],
        parentPh: json["parent_ph"],
        id: json["id"],
        rollNo: json["roll_no"],
      );

  Map<String, dynamic> toJson() => {
        "student_name": studentName,
        "student_class": studentClass,
        "teacher_name": teacherName,
        "parent_name": parentName,
        "parent_ph": parentPh,
        "id": id,
        "roll_no": rollNo,
      };
}
