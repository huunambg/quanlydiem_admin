import 'package:flutter/material.dart';
import '/config/global_text_style.dart';
import '/model/class.dart';

class ItemClassCustom extends StatelessWidget {
  const ItemClassCustom({super.key, required this.classes, required this.onTap});
  final Class classes;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Màu bóng đổ
              blurRadius: 6.0, // Độ mờ của bóng
              spreadRadius: 2.0, // Độ lan của bóng
              offset: Offset(0, 3), // Độ lệch của bóng (x, y)
            ),
          ],
          color: Colors.white, // Màu nền
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  color: Colors.blue,
                ),
                width: double.infinity,
                child: Text(
                  classes.className!,
                  style: GlobalTextStyles.font16w600ColorWhite,
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
