import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/screen/classes_grade/classes_grade_screen.dart';
import '/config/api_state.dart';
import '/config/global_text_style.dart';
import '/model/subject.dart';
import '/screen/subject/controller/subject_controller.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({
    super.key,
  });
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final subjectCtl = Get.find<SubjectController>();

  @override
  void initState() {
    super.initState();
    subjectCtl.loadSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Danh sách môn học")),
      body: Obx(
        () {
          switch (subjectCtl.apiState.value) {
            case ApiState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ApiState.success:
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0),
                itemCount: subjectCtl.listSubject.length,
                itemBuilder: (context, index) {
                  Subject subject = subjectCtl.listSubject[index];
                  return GestureDetector(
                    onTap: () => Get.to(ClassesGradeScreen(
                      subject: subject,
                    )),
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 24.0),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0))),
                              child: Text(
                                subject.subjectName!,
                                style: GlobalTextStyles.font24w700ColorWhite,
                              ),
                            ),
                          ),
                          const Gap(16),
                          const Expanded(
                            flex: 5,
                            child: SizedBox(),
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
    );
  }
}
