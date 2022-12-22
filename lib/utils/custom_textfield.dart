import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regent/utils/colors.dart';


class AppTextField extends StatelessWidget {
  AppTextField(
      {Key? key,
        required this.hint,
        required this.textInputType,
        required this.textCapitalization,
        required this.controller})
      : super(key: key);
  String hint;
  TextCapitalization textCapitalization;
  TextInputType textInputType;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.1, color: AppColors.textColor),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        style: GoogleFonts.sourceSansPro(
          textStyle: const TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:  GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
                color: Color(0xffC8C7CE),
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          border: InputBorder.none,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 7.0, top: 6.0),
        ),
      ),
    );
  }
}

class AppText extends StatelessWidget {
  AppText({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.quicksand(
        textStyle: const TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 14),
      ),
    );
  }
}

