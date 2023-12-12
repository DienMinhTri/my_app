// Flutter imports:
import 'package:flutter/material.dart';
import 'package:my_app/helper/toast/toast.dart';
import 'package:sizer/sizer.dart';

toastNotification(
  String title, {
  String? image,
  IconData? icon,
  Color? backgroundColor,
  Widget? customAnimation,
  Color? colorText,
  Color? colorIcon,
  double? textSize,
  double? sizeIcon,
  FontWeight? textWeight,
  bool? isSuccess,
}) {
  BotToast.showAnimationWidget(
    onlyOne: true,
    toastBuilder: (_) {
      return GestureDetector(
        onTap: () {
          _.call();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(8.sp),
            elevation: 2.0,
            color: backgroundColor ?? Colors.white,
            child: Row(
              children: [
                Container(
                  width: 5.sp,
                  height: 42.sp,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(5.sp)),
                    color: colorIcon ?? Colors.green,
                  ),
                ),
                SizedBox(width: 10.sp),
                image != null
                    ? Image.asset(
                        image,
                        width: sizeIcon ?? 16.sp,
                        color: colorIcon ?? Colors.green,
                      )
                    : Icon(
                        icon ?? Icons.check_circle,
                        size: sizeIcon ?? 16.sp,
                        color: colorIcon ?? Colors.green,
                      ),
                SizedBox(width: 10.sp),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorText ?? Colors.black,
                      fontSize: textSize ?? 11.sp,
                      fontWeight: textWeight ?? FontWeight.w500,
                      height: 1.25.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
