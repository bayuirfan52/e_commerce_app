import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   modified              : Bayu Irfan
///   originalFilename      : ex_text_field_icon
///   date                  : 24 Jun 2021
///   date modified         : 16 Jul 2022
///   —————————————————————————————————————————————————————————————————————————————
///   <img width="442" alt="image" src="https://user-images.githubusercontent.com/36602270/169626769-340a5654-d4cc-4f93-9c07-bb408157e10b.png">

class ExTextFieldLabeled extends StatelessWidget {
  const ExTextFieldLabeled({
    required this.label,
    super.key,
    this.tfController,
    this.textInputAction,
    this.onSubmitted,
    this.textColor,
    this.hint,
    this.isPassword,
    this.obscureText,
    this.borderRadius = 4,
    this.borderColor = const Color(0xFFe4e8eb),
    this.labelSize,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController? tfController;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  final Color? textColor;
  final String? hint;
  final bool? isPassword;
  final bool? obscureText;
  final double borderRadius;
  final Color borderColor;
  final Widget label;
  final double? labelSize;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: VStack([
        label,
        8.heightBox,
        VxTextField(
          borderType: VxTextFieldBorderType.none,
          fillColor: Colors.white,
          isPassword: isPassword ?? false,
          obscureText: obscureText ?? false,
          hint: hint,
          style: GoogleFonts.openSans(color: textColor),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          controller: tfController,
          onSubmitted: onSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
      ]).pOnly(top: 16, left: 16, bottom: 8, right: 16),
    );
  }
}
