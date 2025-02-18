import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/config/global_color.dart';
import 'package:quanlydiem_admin/screen/notification/controller/notification_controller.dart';
import 'package:quanlydiem_admin/services/api.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({Key? key}) : super(key: key);

  @override
  _AddNotificationScreenState createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ApiService().addNotification({
        "message": descriptionController.text,
        "title": titleController.text,
        "topic": "news"
      }).then(
        (value) {
          final notificationCtl = Get.find<NotificationController>();
          notificationCtl.loadData();
          CherryToast.success(
            title: const Text("Thêm thông báo thành công"),
          ).show(context);
        },
      ).catchError((e) {
        CherryToast.error(
          title: const Text("Thêm thông báo thất bại"),
        ).show(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notification"),
        backgroundColor: Colors.deepPurple, // Thêm màu sắc cho AppBar
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // Đảm bảo form có thể scroll được khi bàn phím xuất hiện
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Nhập nội dung thông báo:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Tiêu đề',
                  border: OutlineInputBorder(), // Thêm viền cho TextFormField
                  prefixIcon: Icon(Icons.title), // Thêm icon
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Nội dung',
                  border: OutlineInputBorder(), // Thêm viền
                  prefixIcon: Icon(Icons.message), // Thêm icon
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.primary, // Màu nút
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Gửi thông báo'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
