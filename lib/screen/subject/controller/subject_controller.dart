import 'package:get/get.dart';
import '/config/api_state.dart';

import '/model/subject.dart';
import '/screen/login/controller/login_controller.dart';
import '/services/api.dart';

class SubjectController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<Subject> listSubject = <Subject>[].obs;

  void loadSubject() async {
    apiState.value = ApiState.loading;
    final loginCtl = Get.find<LoginController>();
    try {
      listSubject.value = await ApiService().getSubject(loginCtl.accessToken);
      apiState.value = ApiState.success;
    } catch (e) {
      print(e);
    }
  }

  Subject getSubject(int id) {
    for (var element in listSubject) {
      if (element.subjectId == id) return element;
    }
    return Subject();
  }
}
