import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '/config/api_state.dart';
import '/model/student.dart';
import '/screen/login/controller/login_controller.dart';
import '/services/api.dart';

class StudentController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<Student> listStudent = <Student>[].obs;

  void loadData(int classId) async {
    final loginCtl = Get.find<LoginController>();
    apiState.value = ApiState.loading;
    try {
      listStudent.value = await ApiService().getStudentByClass(classId);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }

  void addStudent(BuildContext context, Student student) async {
    final loginCtl = Get.find<LoginController>();
    apiState.value = ApiState.loading;
    print(student.toJson());
    try {
      await ApiService().addStudent(student);
      listStudent.add(student);
      CherryToast.success(
        title: const Text("Thêm sinh viên thành công"),
      ).show(context);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }

  void updateStudent(BuildContext context, Student student) async {
    apiState.value = ApiState.loading;
    try {
      await ApiService().updateStudent(student);
      int index = listStudent.indexWhere(
        (element) => element.studentId == student.studentId,
      );
      listStudent[index] = student;
      CherryToast.success(
        title: const Text("Cập nhật học sinh thành công"),
      ).show(context);
      apiState.value = ApiState.success;
    } catch (e) {
      print(e);
      apiState.value = ApiState.failure;
    }
  }
}
