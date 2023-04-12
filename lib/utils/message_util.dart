import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:simple_crud_bloc/utils/res_color.dart';


class MessageUtil {
  MessageUtil._();

  static void showSuccessOverlay( BuildContext context,
      {required String message, Duration? duration, VoidCallback? onDismissed}) {
    Flushbar(
      message: message,
      titleColor: Colors.white,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: ResColor.colorPrimary2,
      boxShadows: const [
        BoxShadow(
            color: Colors.black45, offset: Offset(0.0, 2.0), blurRadius: 1.0)
      ],
      margin: const EdgeInsets.symmetric(horizontal: 16),
      isDismissible: true,
      duration: duration ?? const Duration(milliseconds: 1500),
      
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) {
          onDismissed?.call();
        }
      },
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: ResColor.colorPrimary2,
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(Colors.white),

    ).show(context);
  }



  static void showErrorOverlay(BuildContext context,
      {required String message,
      Duration? duration,
      VoidCallback? onDismissed}) {
    Flushbar(
      titleColor: Colors.white,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: ResColor.red,
      progressIndicatorBackgroundColor: Colors.white,

      boxShadows: const [
        BoxShadow(
            color: Colors.black45, offset: Offset(0.0, 2.0), blurRadius: 1.0)
      ],
      margin: const EdgeInsets.symmetric(horizontal: 16),
      isDismissible: false,
      duration: duration ?? const Duration(milliseconds: 2500),
      icon: const Icon(
        Icons.close,
        color: Colors.white,
      ),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.IS_HIDING) {
          onDismissed?.call();
        }
      },
      showProgressIndicator: false,
    ).show(context);
  }


}
