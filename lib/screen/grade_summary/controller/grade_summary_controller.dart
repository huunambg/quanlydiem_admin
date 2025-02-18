import 'package:get/get.dart';
import 'package:quanlydiem_admin/model/summary.dart';
import 'package:quanlydiem_admin/services/api.dart';
import '/config/api_state.dart';
import '/const/semester.dart';

class SummaryGradeController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<SummaryGrade> listSummaryGrade = <SummaryGrade>[].obs;
  Rx<Semester> semester = Semester.semester1.obs;

  List<SummaryGrade> getListSummaryGrade() {
    if (semester == Semester.semester1) {
      return listSummaryGrade
          .where(
            (p0) => p0.semester == "1",
          )
          .toList();
    } else {
      return listSummaryGrade
          .where(
            (p0) => p0.semester == "2",
          )
          .toList();
    }
  }

  void loadData(int classId ) async {
    apiState.value = ApiState.loading;
    try {
      listSummaryGrade.value = await ApiService().getGradeSummary(classId);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }

}
