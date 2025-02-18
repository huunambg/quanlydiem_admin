import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/student.dart';
import '/model/class.dart';
import '/screen/student/controller/student_controller.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key, required this.classes});
  final Class classes;

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final studentCtl = Get.find<StudentController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String? selectedGender;
  bool isManualInput = false;



  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Thêm học sinh"),
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
                  "Họ tên",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                _buildTextFormField(
                  controller: nameController,
                  hintText: "Nhập họ tên",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Họ tên không được để trống";
                    }
                    return null;
                  },
                ),
                const Gap(16),
                const Text(
                  "Ngày sinh",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                _buildTextFormField(
                  controller: dobController,
                  hintText: "Nhập ngày sinh (DD/MM/YYYY)",
                  icon: Icons.calendar_today,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Ngày sinh không được để trống";
                    }
                    final regex = RegExp(
                        r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$");
                    if (!regex.hasMatch(value)) {
                      return "Ngày sinh không đúng định dạng";
                    }
                    return null;
                  },
                ),
                const Gap(16),
                const Text(
                  "Địa chỉ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                _buildTextFormField(
                  controller: addressController,
                  hintText: "Nhập địa chỉ",
                  icon: Icons.home,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Địa chỉ không được để trống";
                    }
                    return null;
                  },
                ),
                const Gap(16),
                const Text(
                  "Giới tính",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Row(
                  children: [
                    _buildRadioButton(
                      value: "male",
                      groupValue: selectedGender,
                      label: "Nam",
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    const Gap(16),
                    _buildRadioButton(
                      value: "female",
                      groupValue: selectedGender,
                      label: "Nữ",
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ],
                ),
                const Gap(24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        studentCtl.addStudent(
                            context,
                            Student(
                                fullName: nameController.text,
                                address: addressController.text,
                                classId: widget.classes.classId,
                                dateOfBirth: dobController.text,
                                gender: selectedGender,
                                studentId: 0));
                        addressController.clear();
                        nameController.clear();
                        dobController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      "Lưu",
                      style: TextStyle(fontSize: 16),
                    ),
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
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildRadioButton({
    required String value,
    required String? groupValue,
    required String label,
    required void Function(String?) onChanged,
  }) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
