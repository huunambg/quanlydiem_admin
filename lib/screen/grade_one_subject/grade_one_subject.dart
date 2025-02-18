import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/screen/add_grade/add_grade_screen.dart';
import '/config/api_state.dart';
import '/config/global_text_style.dart';
import '/const/semester.dart';
import '/model/class.dart';
import '/model/grade_with_student.dart';
import '/model/subject.dart';
import '/screen/grade_one_subject/controller/grade_one_subject_controller.dart';

class GradeOneSubjectScreen extends StatefulWidget {
  const GradeOneSubjectScreen(
      {super.key, required this.classes, required this.subject});
  final Class classes;
  final Subject subject;

  @override
  State<GradeOneSubjectScreen> createState() => _GradeOneSubjectScreenState();
}

class _GradeOneSubjectScreenState extends State<GradeOneSubjectScreen> {
  final gradeCtl = Get.find<GradeOneSubjectController>();

  @override
  void initState() {
    super.initState();
    gradeCtl.loadData(widget.classes.classId!, widget.subject.subjectId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "${widget.subject.subjectName!} - ${widget.classes.className} (Học kỳ ${gradeCtl.semester.value == Semester.semester1 ? "1" : "2"})")),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(AddGradeScreen(
                  classes: widget.classes,
                  semester: gradeCtl.semester == Semester.semester1 ? "1" : "2",
                  subjectId: widget.subject.subjectId!,
                ));
              },
              child: const Icon(Icons.add)),
          const SizedBox(
            width: 16.0,
          ),
          PopupMenuButton<Semester>(
            icon: const Icon(Icons.more_vert),
            onSelected: (Semester value) {
              gradeCtl.semester.value = value;
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Semester>>[
              const PopupMenuItem<Semester>(
                value: Semester.semester1,
                child: Text("Học kỳ 1"),
              ),
              const PopupMenuItem<Semester>(
                value: Semester.semester2,
                child: Text("Học kỳ 2"),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          switch (gradeCtl.apiState.value) {
            case ApiState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ApiState.success:
              if (gradeCtl.getListGradleSemester().isEmpty) {
                return const Center(
                  child: Text("Chưa có điểm của học sinh nào."),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blueGrey.shade100),
                  dataRowColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.hovered)
                          ? Colors.blue.shade50
                          : Colors.white),
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(label: Text("Họ và Tên")),
                    DataColumn(label: Text("GTX1")),
                    DataColumn(label: Text("GTX2")),
                    DataColumn(label: Text("GTX3")),
                    DataColumn(label: Text("GTX4")),
                    DataColumn(label: Text("ĐĐGgk")),
                    DataColumn(label: Text("ĐĐGck")),
                    DataColumn(label: Text("ĐTBmhk")),
                    DataColumn(label: Text("Hành động")),
                  ],
                  rows: gradeCtl
                      .getListGradleSemester()
                      .map((GradeWithStudent grade) {
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          grade.fullName!,
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.ddgtx1!.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.ddgtx2!.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.ddgtx3!.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.ddgtx4!.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.ddgGk!.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.ddgCk!.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.dtbMhk!.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {}, child: const Text("Sửa"))
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            case ApiState.failure:
              return const Center(
                child: Text("Error loading grades"),
              );
          }
        }),
      ),
    );
  }
}
