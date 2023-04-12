import 'package:flutter/material.dart';

import '../../utils/res_color.dart';

class SubmitButton extends StatelessWidget {
  final double? borderRadius;
  final Widget? child ;
  const SubmitButton(
      { this.title,
        this.onPressed,
        Key? key,
        this.backgroundColor,
        this.fontColor,
        this.paddingButton =const EdgeInsets.symmetric(vertical: 12),
        this.fontSize,
        this.borderRadius,
        this.width,
        this.height,
        this.child,
        this.gradient})
      : super(key: key);

  const SubmitButton.primaryGradient(
      {required this.title,
        this.onPressed,
        Key? key,
        this.paddingButton = const EdgeInsets.symmetric(vertical: 12),
        this.fontSize,
        this.borderRadius,
        this.fontColor,
        this.width,
        this.height,
        this.child,
        this.gradient = ResColor.primaryGradient})
      : backgroundColor = null,
        super(key: key);
  const SubmitButton.redGradient(
      {required this.title,
        this.onPressed,
        Key? key,
        this.paddingButton = const EdgeInsets.symmetric(vertical: 12),
        this.fontSize,
        this.borderRadius,
        this.fontColor,
        this.width,
        this.height,
        this.child,
        this.gradient = ResColor.errorGradient})
      : backgroundColor = null,
        super(key: key);


  final String? title;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? fontColor;
  final EdgeInsets? paddingButton;
  final double? fontSize;
  final double? width;
  final double? height;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: onPressed != null ? backgroundColor : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 50),
            ),
          ),
          padding: EdgeInsets.zero,
        ),
        // child: const CircularProgressIndicator(),
        child: Ink(
          decoration: BoxDecoration(
            gradient: onPressed != null ? gradient : null,
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 50),
            ),
            color: onPressed != null ? backgroundColor : null,
          ),
          child: Container(
            width: width ?? MediaQuery.of(context).size.width,
            height: height,
            padding: paddingButton ?? const EdgeInsets.symmetric(vertical: 15),
            child: child ?? Text(
              title??'',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize ?? 14,
                  color: fontColor
              ),
            ),
          ),
        ),
      ),
    );
  }
}
