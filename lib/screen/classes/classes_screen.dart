import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/screen/add_class/add_class_screen.dart';
import 'package:quanlydiem_admin/screen/classes/widget/item_class.dart';
import 'package:quanlydiem_admin/screen/setting/setting_controller.dart';
import 'package:quanlydiem_admin/screen/student/student_screen.dart';
import 'package:quanlydiem_admin/screen/update_class/update_class.dart';
import '/config/api_state.dart';
import '/model/class.dart';
import 'controller/class_controller.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key, required this.isTabClass});
  final bool isTabClass;
  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final classesCtl = Get.find<ClassesController>();
  final settingCtl = Get.find<SettingsController>();
  @override
  void initState() {
    super.initState();
    classesCtl.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách lớp học"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
                onPressed: () {
                  Get.to(const AddClassScreen());
                },
                icon: const Icon(Icons.add)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                switch (classesCtl.apiState.value) {
                  case ApiState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ApiState.success:
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      padding: const EdgeInsets.all(10),
                      itemCount: classesCtl
                          .getClassByAcademicYear(settingCtl.currentYear.value!)
                          .length,
                      itemBuilder: (context, index) {
                        Class classes = classesCtl.getClassByAcademicYear(
                            settingCtl.currentYear.value!)[index];
                        return ItemClassCustom(
                          classes: classes,
                          onTap: () {
                            if (widget.isTabClass) {
                              Get.to(UpdateClassScreen(existingClass: classes));
                            } else {
                              Get.to(StudentScreen(classes: classes));
                            }
                          },
                        );
                      },
                    );
                  case ApiState.failure:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
