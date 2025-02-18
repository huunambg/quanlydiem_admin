import 'package:get/get.dart';
import '/config/api_state.dart';
import '/const/semester.dart';
import '/model/grade_with_student.dart';
import '/screen/login/controller/login_controller.dart';
import '/services/api.dart';

class GradeOneSubjectController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<GradeWithStudent> listGrade = <GradeWithStudent>[].obs;
  Rx<Semester> semester = Semester.semester1.obs;



  List<GradeWithStudent> getListGradleSemester() {
    if (semester == Semester.semester1) {
      return listGrade
          .where(
            (p0) => p0.semester == "1",
          )
          .toList();
    } else {
      return listGrade
          .where(
            (p0) => p0.semester == "2",
          )
          .toList();
    }
  }

  void loadData(int classId, int subjectId) async {
    final loginCtl = Get.find<LoginController>();
    apiState.value = ApiState.loading;
    try {
      listGrade.value = await ApiService()
          .getGradeBySubjectClass(classId, subjectId);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }
}
