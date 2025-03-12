import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:quanlydiem_admin/model/notification.dart';
import 'package:quanlydiem_admin/model/summary.dart';
import 'package:quanlydiem_admin/model/teacher.dart';
import 'package:quanlydiem_admin/model/teacher_admin.dart';
import '/model/acount.dart';
import '/model/class.dart';
import '/model/grade.dart';
import '/model/grade_with_student.dart';
import '/model/student.dart';
import '/model/subject.dart';

class ApiService {
  final String baseUrl;
  ApiService()
      : baseUrl =
            "http://192.168.43.7:3000/public/api"; // Thay bằng URL của bạn

  Future<dynamic> login(Account account) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(account.toJson()),
      );
      print("login $response");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      // Lỗi mạng hoặc các lỗi không xác định
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<dynamic> register(Account account) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(account.toJson()),
      );
      return response;
    } catch (e) {
      // Lỗi mạng hoặc các lỗi không xác định
      print("Network error: $e");
      throw "Unable to connect to server. Please check your internet connection.";
    }
  }

  Future<void> deleteTeacher(TeacherAdmin teacher) async {
    final url = Uri.parse('$baseUrl/delete-user/${teacher.userId}');
    print(url);
    try {
      final response = await http.delete(url, headers: {});
      print(
          "deleteTeacher ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
      } else {
        throw "cập nhật deleteTeacher.";
      }
    } catch (e) {
      print("deleteTeacher: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<void> updateTeacher(TeacherAdmin teacher) async {
    final url = Uri.parse('$baseUrl/update-user/${teacher.userId}');
    print(url);
    try {
      final response = await http.put(url, headers: {}, body: teacher.toJson());
      print(
          "getStudupdateTeacherentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
      } else {
        throw "cập nhật updateTeacher.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<TeacherAdmin>> getAllTeacherAdmin() async {
    final url = Uri.parse('$baseUrl/get-all-teacher-admin');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("getAllTeacherAdmin ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<TeacherAdmin> listClass = listData
            .map(
              (e) => TeacherAdmin.fromJson(e),
            )
            .toList();
        return listClass;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> addNotification(Map<String, String> data) async {
    final url = Uri.parse('$baseUrl/add-notification');
    try {
      final response = await http.post(
        url,
        body: data,
      );
      if (response.statusCode != 200) {
        throw ("Error");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteNotification(String id) async {
    final url = Uri.parse('$baseUrl/delete-notification/$id');
    try {
      final response = await http.delete(
        url,
      );
      if (response.statusCode != 200) {
        throw ("Error");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Notifications>> getAllNotification() async {
    final url = Uri.parse('$baseUrl/get-all-notification');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("getAllNotification ${jsonDecode(response.body)['notifications']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['notifications'];
        List<Notifications> listClass = listData
            .map(
              (e) => Notifications.fromJson(e),
            )
            .toList();
        return listClass;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<void> addGrade(Grade grade) async {
    final url = Uri.parse('$baseUrl/add-grade');
    print(url);
    print(grade.toJsonAdd());
    try {
      final response = await http.post(url, body: grade.toJsonAdd());
      print("addGrade ${jsonDecode(response.body)}");
      if (response.statusCode != 200) {
        throw response.body;
      }
    } catch (e) {
      print("addGrade: $e");
      rethrow;
    }
  }

  Future<List<Class>> getAllClass() async {
    final url = Uri.parse('$baseUrl/get-all-class/');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("getListClassByTeacher ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Class> listClass = listData
            .map(
              (e) => Class.fromJson(e),
            )
            .toList();
        return listClass;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Student>> getStudentByClass(int classId) async {
    final url = Uri.parse('$baseUrl/get-student-by-class/$classId');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Student> listStudent = listData
            .map(
              (e) => Student.fromJson(e),
            )
            .toList();
        return listStudent;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Subject>> getSubject(String accessToken) async {
    final url = Uri.parse('$baseUrl/get-all-subject');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("getSubject ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Subject> listSubject = listData
            .map(
              (e) => Subject.fromJson(e),
            )
            .toList();
        return listSubject;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Teacher>> getAllTeacher() async {
    final url = Uri.parse('$baseUrl/get-all-teacher');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("getAllTeacher ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Teacher> listSubject = listData
            .map(
              (e) => Teacher.fromJson(e),
            )
            .toList();
        return listSubject;
      } else {
        throw "Lỗi khi lấy dữ liệu!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Grade>> getGradeByClassAndStudent(
      int classId, int studentId) async {
    final url = Uri.parse('$baseUrl/get-grade-by-class-and-student');
    print(url);
    try {
      final response = await http.post(url,
          headers: {},
          body: {"class_id": "$classId", "student_id": "$studentId"});
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Grade> listGrade = listData
            .map(
              (e) => Grade.fromJson(e),
            )
            .toList();
        return listGrade;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<SummaryGrade>> getGradeSummary(int classId) async {
    final url = Uri.parse('$baseUrl/get-grade-summary/$classId');
    print(url);
    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['data']);
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<SummaryGrade> listGrade = listData
            .map(
              (e) => SummaryGrade.fromJson(e),
            )
            .toList();
        return listGrade;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<GradeWithStudent>> getGradeBySubjectClass(
      int classId, int subjectId) async {
    final url = Uri.parse('$baseUrl/get-grade-subject-class');
    print(url);
    try {
      final response = await http.post(url,
          headers: {},
          body: {"class_id": "$classId", "subject_id": "$subjectId"});
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<GradeWithStudent> listGrade = listData
            .map(
              (e) => GradeWithStudent.fromJson(e),
            )
            .toList();
        return listGrade;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<void> addStudent(Student student) async {
    final url = Uri.parse('$baseUrl/add-student');
    print(url);
    try {
      final response = await http.post(url, headers: {}, body: {
        "full_name": student.fullName,
        "date_of_birth": student.dateOfBirth,
        "gender": student.gender,
        "address": student.address,
        "class_id": student.classId.toString(),
      });
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
      } else {
        throw "Thêm học sinh thất bại.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<void> updateStudent(Student student) async {
    final url = Uri.parse('$baseUrl/update-student');
    print(url);
    try {
      final response = await http.put(url, headers: {}, body: {
        "student_id": student.studentId.toString(),
        "full_name": student.fullName,
        "date_of_birth": student.dateOfBirth,
        "gender": student.gender,
        "address": student.address,
        "class_id": student.classId.toString(),
        "hk1": student.hk1.toString(),
        "hk2": student.hk2.toString(),
      });
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
      } else {
        throw "cập nhật học sinh thất bại.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<void> addClass(Class classes) async {
    final url = Uri.parse('$baseUrl/add-class');
    print(url);
    try {
      final response = await http.post(url, headers: {}, body: {
        "class_name": classes.className,
        "academic_year": classes.academicYear,
        "teacher_id": classes.teacherId.toString(),
        "status": "1"
      });
      print("addClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
      } else {
        throw "Thêm lớp học thất bại.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<void> updateClass(Class classes) async {
    final url = Uri.parse('$baseUrl/update-class');
    print(url);
    try {
      final response = await http.put(url, headers: {}, body: {
        "class_id": classes.classId.toString(),
        "class_name": classes.className,
        "academic_year": classes.academicYear,
        "teacher_id": classes.teacherId.toString(),
        "status": classes.status.toString()
      });
      print("addClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
      } else {
        throw "Thêm lớp học thất bại.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }
}
