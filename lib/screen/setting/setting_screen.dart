import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/screen/setting/setting_controller.dart';

class SettingScreen extends StatelessWidget {
  final List<String> academicYear = [
    '2024-2025',
    '2025-2026',
    '2026-2027',
    '2027-2028',
    '2028-2029',
    '2029-2030',
  ];

  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: PopupMenuButton<String>(
            onSelected: controller.setAcademicYear,
            itemBuilder: (BuildContext context) {
              return academicYear.map((String year) {
                return PopupMenuItem<String>(
                  value: year,
                  child: Text(year, style: const TextStyle(fontSize: 16)),
                );
              }).toList();
            },
            child: Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(controller.currentYear.value ?? 'Chọn năm học',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.deepPurple)),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_drop_down,
                          color: Colors.deepPurple),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
