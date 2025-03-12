import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/teacher_admin.dart';
import 'package:quanlydiem_admin/services/api.dart';

class TeacherController extends GetxController {
  RxList<TeacherAdmin> listTeacher = <TeacherAdmin>[].obs;

  void getData() async {
    listTeacher.value = await ApiService().getAllTeacherAdmin();
  }

  void updateData(TeacherAdmin teacher) async {
    await ApiService().updateTeacher(teacher);
    getData();
  }

    void deleteData(TeacherAdmin teacher) async {
    await ApiService().deleteTeacher(teacher);
    getData();
  }
}
