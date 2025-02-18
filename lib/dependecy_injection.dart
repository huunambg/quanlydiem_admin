import 'package:quanlydiem_admin/screen/add_grade/controller/add_grade_controller.dart';
import 'package:quanlydiem_admin/screen/classes/controller/class_controller.dart';
import 'package:quanlydiem_admin/screen/notification/controller/notification_controller.dart';
import 'package:quanlydiem_admin/screen/setting/setting_controller.dart';
import 'package:quanlydiem_admin/screen/splash/controller/splash_controller.dart';
import 'package:quanlydiem_admin/screen/student/controller/student_controller.dart';
import 'package:quanlydiem_admin/screen/subject/controller/subject_controller.dart';
import '/util/preferences_util.dart';
import 'package:get/get.dart';
import 'screen/grade_one_subject/controller/grade_one_subject_controller.dart';
import 'screen/grade_summary/controller/grade_summary_controller.dart';
import 'screen/login/controller/login_controller.dart';

Future<void> init() async {
  await PreferencesUtil.init();
  final loginController = LoginController();
  Get.lazyPut(() => loginController, fenix: true);
  final splashController = SplashController();
  Get.lazyPut(() => splashController, fenix: true);
  final classesController = ClassesController();
  Get.lazyPut(() => classesController, fenix: true);
  final studentController = StudentController();
  Get.lazyPut(() => studentController, fenix: true);
  final subjectController = SubjectController();
  Get.lazyPut(() => subjectController, fenix: true);
  final gradeOneSubjectController = GradeOneSubjectController();
  Get.lazyPut(() => gradeOneSubjectController, fenix: true);
  final addGradeController = AddGradeController();
  Get.lazyPut(() => addGradeController, fenix: true);
  final notificationController = NotificationController();
  Get.lazyPut(() => notificationController, fenix: true);
  final settingController = SettingsController();
  Get.lazyPut(() => settingController, fenix: true);
  final summaryGradeController = SummaryGradeController();
  Get.lazyPut(() => summaryGradeController, fenix: true);
}
