import 'package:get/get.dart';
import 'package:quanlydiem_admin/util/preferences_util.dart';

class SettingsController extends GetxController {
  final PreferencesUtil _prefs = PreferencesUtil();
  var currentYear = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    loadAcademicYear();
  }

  void loadAcademicYear() async {
    final year = await _prefs.getAcademicYear();
    currentYear.value = year;
  }

  void setAcademicYear(String year) async {
    await _prefs.setAcademicYear(year);
    currentYear.value = year;
  }
}
