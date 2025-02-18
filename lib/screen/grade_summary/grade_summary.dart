import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/summary.dart';
import 'package:quanlydiem_admin/screen/add_grade/add_grade_screen.dart';
import 'package:quanlydiem_admin/screen/grade_summary/controller/grade_summary_controller.dart';
import '/config/api_state.dart';
import '/config/global_text_style.dart';
import '/const/semester.dart';
import '/model/class.dart';

import '/model/subject.dart';

class GradeSummaryScreen extends StatefulWidget {
  const GradeSummaryScreen({super.key, required this.classes});
  final Class classes;

  @override
  State<GradeSummaryScreen> createState() => _GradeSummaryScreenState();
}

class _GradeSummaryScreenState extends State<GradeSummaryScreen> {
  final summaryGradeCtl = Get.find<SummaryGradeController>();

  @override
  void initState() {
    super.initState();
    summaryGradeCtl.loadData(widget.classes.classId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "${widget.classes.className} (Học kỳ ${summaryGradeCtl.semester.value == Semester.semester1 ? "1" : "2"})")),
        centerTitle: true,
        actions: [
          PopupMenuButton<Semester>(
            icon: const Icon(Icons.more_vert),
            onSelected: (Semester value) {
              summaryGradeCtl.semester.value = value;
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
          switch (summaryGradeCtl.apiState.value) {
            case ApiState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ApiState.success:
              if (summaryGradeCtl.getListSummaryGrade().isEmpty) {
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
                    DataColumn(label: Text("Toán học")),
                    DataColumn(label: Text("Vật lí")),
                    DataColumn(label: Text("Hóa học")),
                    DataColumn(label: Text("Sinh học")),
                    DataColumn(label: Text("Tin học")),
                    DataColumn(label: Text("Ngữ văn")),
                    DataColumn(label: Text("Lịch sử")),
                    DataColumn(label: Text("Địa lí")),
                    DataColumn(label: Text("Tiếng anh")),
                    DataColumn(label: Text("GDCD")),
                    DataColumn(label: Text("Công nghệ")),
                    DataColumn(label: Text("Thể dục")),
                    DataColumn(label: Text("GDQP")),
                    DataColumn(label: Text("TBcmlhkl")),
                    DataColumn(label: Text("Hạnh kiểm")),
                    DataColumn(label: Text("Xếp loại"))
                  ],
                  rows: summaryGradeCtl
                      .getListSummaryGrade()
                      .map((SummaryGrade grade) {
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          grade.fullName,
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.toanHoc == null ? "" : grade.toanHoc.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.vatLi == null ? "" : grade.vatLi.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.hoaHoc == null ? "" : grade.hoaHoc.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.sinhHoc == null ? "" : grade.sinhHoc.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.tinHoc == null ? "" : grade.tinHoc.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.nguVan == null ? "" : grade.nguVan.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.lichSu == null ? "" : grade.lichSu.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.diaLi == null ? "" : grade.diaLi.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.tiengAnh == null
                              ? ""
                              : grade.tiengAnh.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.gdcd == null ? "" : grade.gdcd.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.congNghe == null
                              ? ""
                              : grade.congNghe.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.theDuc == null ? "" : grade.theDuc.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.gdqp == null ? "" : grade.gdqp.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          grade.tbcmlhkl == null
                              ? ""
                              : grade.tbcmlhkl.toString(),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          summaryGradeCtl.semester == Semester.semester1
                              ? grade.hk1
                              : grade.hk2,
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
                        DataCell(Text(
                          calXeploai(grade.tbcmlhkl),
                          style: GlobalTextStyles.font16w600Color8A96B2
                              .copyWith(color: Colors.black),
                        )),
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

  String calXeploai(double dtb) {
    if (dtb >= 8) {
      return "Giỏi";
    } else if (dtb < 8 && dtb > 6.5) {
      "Khá";
    } else if (dtb < 6.5 && dtb >= 5) {
      return "TB";
    }
    return "Yếu";
  }
}
