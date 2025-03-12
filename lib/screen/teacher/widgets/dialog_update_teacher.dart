import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/teacher_admin.dart';
import 'package:quanlydiem_admin/screen/teacher/teacher_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class DialogEditTeacher extends StatefulWidget {
  const DialogEditTeacher({super.key, required this.teacher});
  final TeacherAdmin teacher;

  @override
  State<DialogEditTeacher> createState() => _DialogEditTeacherState();
}

class _DialogEditTeacherState extends State<DialogEditTeacher> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final teacherCtl = Get.find<TeacherController>();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.teacher.fullName!;
    emailController.text = widget.teacher.email!;
    phoneController.text = widget.teacher.phoneNumber ?? "0";
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Sửa thông tin người dùng',
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Họ và tên',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const Gap(20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const Gap(20),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            PanaraConfirmDialog.show(
              context,
              title: "Xóa giáo viên",
              message: "Bạn sẽ không thể khôi phục sau khi xóa ",
              confirmButtonText: "Xóa",
              cancelButtonText: "Quay lại",
              onTapCancel: () {
                Get.back();
              },
              onTapConfirm: () async {
                Get.back();
                teacherCtl.updateData(widget.teacher);
              },
              panaraDialogType: PanaraDialogType.warning,
            );
          },
          child: const Text('Xóa'),
        ),
        ElevatedButton(
          onPressed: () {
            String newName = nameController.text;
            String newEmail = emailController.text;
            String newPhone = phoneController.text;
            TeacherAdmin teacherAdmin = widget.teacher.copyWith(
                fullName: newName, phoneNumber: newPhone, email: newEmail);
            teacherCtl.updateData(teacherAdmin);
            Navigator.pop(context);
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
