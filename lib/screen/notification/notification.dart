import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quanlydiem_admin/config/api_state.dart';
import 'package:quanlydiem_admin/screen/add_notification/add_notification.dart';
import 'package:quanlydiem_admin/screen/notification/controller/notification_controller.dart';
import 'package:quanlydiem_admin/services/api.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  DateTime today = DateTime.now();
  final notificationCtl = Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();
    notificationCtl.loadData();
  }

  String formatDay(int day) {
    if (day < 10) {
      return "0$day";
    } else {
      return "$day";
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Thông báo"),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to((const AddNotificationScreen()));
              },
              child: const Icon(Icons.add)),
          const SizedBox(
            width: 16.0,
          ),
        ],
      ),
      body: Obx(
        () => notificationCtl.apiState == ApiState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: notificationCtl.listNotification.length,
                itemBuilder: (context, index) {
                  final noti = notificationCtl.listNotification[index];
                  return GestureDetector(
                    onLongPress: () {
                      ApiService().deleteNotification(noti.id!);
                      notificationCtl.loadData();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 8),
                      width: w,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Text(
                                (1 + index).toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                          Gap(5),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Thông báo: ${noti.message!.title}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                              Text("Nội dung: ${noti.message!.message}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                              Text(
                                  "Thời gian: ${DateFormat('hh:mm - dd/MM/yyyy').format(DateTime.parse(noti.message!.time!))}")
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
