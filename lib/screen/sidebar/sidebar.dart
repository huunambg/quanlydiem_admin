import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quanlydiem_admin/config/global_text_style.dart';
import 'package:quanlydiem_admin/model/summary.dart';
import 'package:quanlydiem_admin/screen/classes/classes_screen.dart';
import 'package:quanlydiem_admin/screen/classes_grade_summary/classes_grade_summary_screen.dart';
import 'package:quanlydiem_admin/screen/grade_summary/grade_summary.dart';
import 'package:quanlydiem_admin/screen/home/home_page.dart';
import 'package:quanlydiem_admin/screen/notification/notification.dart';
import 'package:quanlydiem_admin/screen/setting/setting_screen.dart';
import 'package:quanlydiem_admin/screen/subject/subject.dart';
import 'package:quanlydiem_admin/screen/teacher/teacher_screen.dart';
import 'package:sidebarx/sidebarx.dart';

class SidebarApp extends StatelessWidget {
  SidebarApp({super.key});

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          appBar: isSmallScreen
              ? AppBar(
                  backgroundColor: canvasColor,
                  title: Text(_getTitleByIndex(_controller.selectedIndex)),
                  leading: IconButton(
                    onPressed: () {
                      // if (!Platform.isAndroid && !Platform.isIOS) {
                      //   _controller.setExtended(true);
                      // }
                      _key.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                )
              : null,
          drawer: ExampleSidebarX(controller: _controller),
          body: Row(
            children: [
              if (!isSmallScreen) ExampleSidebarX(controller: _controller),
              Expanded(
                child: Center(
                  child: _ScreensExample(
                    controller: _controller,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    super.key,
    required SidebarXController controller,
  }) : _controller = controller;

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset(
                    'assets/images/man.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                const Gap(16.0),
                Text(
                  "Tải Thị Bằng",
                  style: GlobalTextStyles.font14w600ColorWhite,
                )
              ],
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.dashboard,
          label: 'Trang chủ',
        ),
        SidebarXItem(
          icon: Icons.class_outlined,
          label: 'Lớp học',
        ),
        SidebarXItem(
          icon: Icons.person_outline,
          label: 'Học sinh',
        ),
        SidebarXItem(
          icon: Icons.grade_outlined,
          label: 'Bảng điểm môn học',
        ),
        SidebarXItem(
          icon: Icons.grade_outlined,
          label: 'Bảng điểm tổng kết',
        ),
        SidebarXItem(
          icon: Icons.person,
          label: 'Giáo viên',
        ),
        SidebarXItem(
          icon: Icons.notifications,
          label: 'Thông báo',
        ),
        SidebarXItem(
          icon: Icons.settings_outlined,
          label: 'Cài đặt',
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    super.key,
    required this.controller,
  });

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return DashboardPage();
          case 1:
            return const ClassesScreen(
              isTabClass: true,
            );
          case 2:
            return const ClassesScreen(
              isTabClass: false,
            );
          case 3:
            return const SubjectScreen();
          case 4:
            return const ClassesGradeSummaryScreen();
          case 5:
            return const TeacherScreen();
          case 6:
            return const NotificationScreen();
          case 7:
            return SettingScreen();
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Notification';
    case 5:
      return 'Settings';
    case 6:
      return 'Notifications';
    default:
      return 'Not found page';
  }
}

const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
