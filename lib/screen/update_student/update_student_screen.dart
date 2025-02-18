import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/student.dart';
import 'package:quanlydiem_admin/widget/button.dart';
import '/screen/student/controller/student_controller.dart';

class UpdateStudentScreen extends StatefulWidget {
  const UpdateStudentScreen({super.key, required this.student});
  final Student student;

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final studentCtl = Get.find<StudentController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? selectedGender;
  String? hk1;
  String? hk2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> conductGrades = [
    "Không có",
    "Tốt",
    "Khá",
    "Trung bình",
    "Yếu"
  ]; // Thêm "Không có" vào danh sách

  @override
  void initState() {
    super.initState();
    // Load initial data from the student to update
    nameController.text = widget.student.fullName ?? '';
    addressController.text = widget.student.address ?? '';
    dobController.text = widget.student.dateOfBirth ?? '';
    hk1 = widget.student.hk1;
    hk2 = widget.student.hk2;
    selectedGender = widget.student.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cập nhật học sinh"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Họ tên", nameController, Icons.person,
                    "Họ tên không được để trống"),
                _buildTextField("Ngày sinh", dobController,
                    Icons.calendar_today, "Ngày sinh không được để trống"),
                _buildTextField("Địa chỉ", addressController, Icons.home,
                    "Địa chỉ không được để trống"),
                _buildGenderSelector(),
                _buildConductGrade("Hạnh kiểm Hk1", "Chọn hạnh kiểm Hk1", hk1,
                    (String? newValue) {
                  setState(() {
                    hk1 = newValue;
                  });
                }),
                _buildConductGrade("Hạnh kiểm Hk2", "Chọn hạnh kiểm Hk2", hk2,
                    (String? newValue) {
                  setState(() {
                    hk2 = newValue;
                  });
                }),
                const Gap(24),
                ButtonCustom(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        studentCtl.updateStudent(
                          context,
                          Student(
                            fullName: nameController.text,
                            address: addressController.text,
                            classId: widget.student.classId,
                            dateOfBirth: dobController.text,
                            gender: selectedGender,
                            studentId: widget.student.studentId,
                            hk1: hk1 != "Không có"
                                ? hk1
                                : null, // Xử lý không cập nhật hạnh kiểm nếu chọn "Không có"
                            hk2: hk2 != "Không có" ? hk2 : null,
                          ),
                        );
                      }
                    },
                    title: "Cập nhật")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, String errorMessage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Gap(8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: "Nhập $label",
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? errorMessage : null,
        ),
        const Gap(16),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Giới tính",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Gap(8),
        Row(
          children: [
            _buildRadioButton("male", "Nam"),
            const Gap(16),
            _buildRadioButton("female", "Nữ"),
          ],
        ),
        const Gap(16),
      ],
    );
  }

  Widget _buildRadioButton(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedGender,
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildConductGrade(String label, String hintText, String? currentValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Gap(8),
        DropdownButtonFormField<String>(
          value: conductGrades.contains(currentValue) ? currentValue : null,
          hint: Text(hintText),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
          onChanged: onChanged,
          items: conductGrades.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const Gap(16),
      ],
    );
  }
}
