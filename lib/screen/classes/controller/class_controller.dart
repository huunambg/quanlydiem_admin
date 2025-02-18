import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/teacher.dart';
import 'package:quanlydiem_admin/screen/setting/setting_controller.dart';
import '/config/api_state.dart';
import '/model/class.dart';
import '/screen/login/controller/login_controller.dart';
import '/services/api.dart';

class ClassesController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<Class> listClass = <Class>[].obs;
  RxList<Teacher> listTeacher = <Teacher>[].obs;
  void loadData() async {
    final loginCtl = Get.find<LoginController>();
    apiState.value = ApiState.loading;
    try {
      listClass.value = await ApiService().getAllClass();

      listTeacher.value = await ApiService().getAllTeacher();

      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }

  List<Class> getClassByAcademicYear(String currentYear) {
    List<Class> list = [];

    for (var element in listClass) {
      if (element.academicYear == currentYear) {
        list.add(element);
      }
    }
    return list;
  }

  void addClass(BuildContext context, Class classes) async {
    apiState.value = ApiState.loading;
    try {
      await ApiService().addClass(classes);
      listClass.add(classes);
      CherryToast.success(
        title: const Text("Thêm lớp thành công"),
      ).show(context);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }

  void updateClass(BuildContext context, Class classes) async {
    apiState.value = ApiState.loading;
    try {
      await ApiService().updateClass(classes);
      int index = listClass.indexWhere(
        (element) => element.classId == classes.classId,
      );
      listClass[index] = classes;
      CherryToast.success(
        title: const Text("Cập nhật lớp thành công"),
      ).show(context);
      apiState.value = ApiState.success;
    } catch (e) {
      print(e);
      apiState.value = ApiState.failure;
    }
  }
}
