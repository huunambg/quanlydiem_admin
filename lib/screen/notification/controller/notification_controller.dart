import 'package:get/get.dart';
import 'package:quanlydiem_admin/config/api_state.dart';
import 'package:quanlydiem_admin/model/notification.dart';
import 'package:quanlydiem_admin/services/api.dart';

class NotificationController extends GetxController {
  RxList<Notifications> listNotification = <Notifications>[].obs;
  var apiState = ApiState.loading.obs;
  void loadData() async {
    try {
      apiState.value = ApiState.loading;
      listNotification.value = await ApiService().getAllNotification();
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }




}
