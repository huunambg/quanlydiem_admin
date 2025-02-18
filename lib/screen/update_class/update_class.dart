import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/class.dart';
import 'package:quanlydiem_admin/model/teacher.dart';
import 'package:quanlydiem_admin/screen/classes/controller/class_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class UpdateClassScreen extends StatefulWidget {
  final Class existingClass;

  const UpdateClassScreen({Key? key, required this.existingClass})
      : super(key: key);

  @override
  State<UpdateClassScreen> createState() => _UpdateClassScreenState();
}

class _UpdateClassScreenState extends State<UpdateClassScreen> {
  final classCtl = Get.find<ClassesController>();
  late TextEditingController nameController;
  late int? selectedStatus;
  late String? selectedYear;
  late Teacher? selectedTeacher;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> academicYear = [
    '2024-2025',
    '2025-2026',
    '2026-2027',
    '2027-2028',
    '2028-2029',
    '2029-2030',
  ];

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.existingClass.className);
    selectedStatus = widget.existingClass.status;
    selectedYear = widget.existingClass.academicYear;
    final classCtl = Get.find<ClassesController>();
    int index = classCtl.listTeacher.indexWhere(
      (p0) => p0.userId == widget.existingClass.teacherId,
    );

    selectedTeacher = classCtl.listTeacher[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cập nhật lớp học"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tên lớp",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                _buildTextFormField(
                  controller: nameController,
                  hintText: "Nhập tên lớp",
                  icon: Icons.class_,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tên lớp không được để trống";
                    }
                    return null;
                  },
                ),
                const Text(
                  "Năm học",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                DropdownButton2<String>(
                  isExpanded: true,
                  items: academicYear
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  value: selectedYear,
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),
                const Text(
                  "Giáo viên chủ nhiệm",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                DropdownButton2<Teacher>(
                  isExpanded: true,
                  items: classCtl.listTeacher
                      .map((teacher) => DropdownMenuItem<Teacher>(
                            value: teacher,
                            child: Text(teacher.fullName!),
                          ))
                      .toList(),
                  value: selectedTeacher,
                  onChanged: (value) {
                    setState(() {
                      selectedTeacher = value;
                    });
                  },
                ),
                const Text(
                  "Trạng thái",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                DropdownButton2<int>(
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem<int>(value: 1, child: Text("Hoạt động")),
                    DropdownMenuItem<int>(
                        value: 0, child: Text("Không hoạt động")),
                  ],
                  value: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                const Gap(24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Class updatedClass = Class(
                          classId: widget.existingClass.classId,
                          className: nameController.text,
                          academicYear: selectedYear,
                          teacherId: selectedTeacher!.userId,
                          status: selectedStatus ?? 1,
                        );
                        classCtl.updateClass(context, updatedClass);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child:
                        const Text("Cập nhật", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      validator: validator,
    );
  }
}
