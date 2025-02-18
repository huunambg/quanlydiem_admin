import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/screen/add_student/add_student_screen.dart';
import 'package:quanlydiem_admin/screen/update_student/update_student_screen.dart';
import '/config/api_state.dart';
import '/config/global_text_style.dart';
import '/model/class.dart';
import '/model/student.dart';
import '/screen/student/controller/student_controller.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, required this.classes});
  final Class classes;
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final studentCtl = Get.find<StudentController>();

  @override
  void initState() {
    super.initState();
    studentCtl.loadData(widget.classes.classId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.classes.className!),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
                onPressed: () {
                  Get.to(AddStudentScreen(classes: widget.classes));
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
                switch (studentCtl.apiState.value) {
                  case ApiState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ApiState.success:
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: studentCtl.listStudent.length,
                      itemBuilder: (context, index) {
                        Student student = studentCtl.listStudent[index];
                        return GestureDetector(
                          onTap: () => Get.to(UpdateStudentScreen(student: student)),
                          child: Card(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 24.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.0),
                                            bottomLeft: Radius.circular(12.0))),
                                    child: Text(
                                      (index + 1).toString(),
                                      style:
                                          GlobalTextStyles.font16w600ColorWhite,
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    student.fullName!,
                                    style:
                                        GlobalTextStyles.font16w600Color8A96B2,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
