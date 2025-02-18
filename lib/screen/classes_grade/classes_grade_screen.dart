import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/subject.dart';
import 'package:quanlydiem_admin/screen/classes/controller/class_controller.dart';
import 'package:quanlydiem_admin/screen/classes/widget/item_class.dart';
import 'package:quanlydiem_admin/screen/grade_one_subject/grade_one_subject.dart';
import '/config/api_state.dart';
import '/model/class.dart';

class ClassesGradeScreen extends StatefulWidget {
  const ClassesGradeScreen({
    super.key,
    required this.subject,
  });
  final Subject subject;
  @override
  State<ClassesGradeScreen> createState() => _ClassesGradeScreenState();
}

class _ClassesGradeScreenState extends State<ClassesGradeScreen> {
  final classesCtl = Get.find<ClassesController>();

  @override
  void initState() {
    super.initState();
    classesCtl.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chọn lớp học"),
        centerTitle: true,
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
                              crossAxisCount: 5,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      padding: const EdgeInsets.all(10),
                      itemCount: classesCtl.listClass.length,
                      itemBuilder: (context, index) {
                        Class classes = classesCtl.listClass[index];
                        return ItemClassCustom(
                          classes: classes,
                          onTap: () {
                            Get.to(GradeOneSubjectScreen(
                                classes: classes, subject: widget.subject));
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
