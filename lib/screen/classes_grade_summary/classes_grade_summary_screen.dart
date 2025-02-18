import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/screen/classes/controller/class_controller.dart';
import 'package:quanlydiem_admin/screen/classes/widget/item_class.dart';
import 'package:quanlydiem_admin/screen/grade_summary/grade_summary.dart';
import '/config/api_state.dart';
import '/model/class.dart';

class ClassesGradeSummaryScreen extends StatefulWidget {
  const ClassesGradeSummaryScreen({
    super.key,
  });
  @override
  State<ClassesGradeSummaryScreen> createState() =>
      _ClassesGradeSummaryScreenState();
}

class _ClassesGradeSummaryScreenState extends State<ClassesGradeSummaryScreen> {
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
                            Get.to(GradeSummaryScreen(classes: classes));
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
