import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CBStyles {
  static TextStyle regular400() {
    return GoogleFonts.poppins(
        color: CBColors.seaweed,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal);
  }

  static TextStyle regular400Italic() {
    return GoogleFonts.poppins(
        color: CBColors.seaweed,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic);
  }

  static TextStyle medium500() {
    return GoogleFonts.poppins(
        color: CBColors.seaweed,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal);
  }

  static TextStyle semiBold600() {
    return GoogleFonts.poppins(
        color: CBColors.seaweed,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal);
  }

  static TextStyle bold700() {
    return GoogleFonts.poppins(
        color: CBColors.seaweed,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal);
  }

  static TextStyle textInputStyle({Color? color}) {
    return const TextStyle(
      color: Color.fromARGB(255, 243, 241, 240),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textInputOrangeStyle({Color? color}) {
    return const TextStyle(
      color: CBColors.lava,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textPageTitleStyle() {
    return const TextStyle(
      color: Color.fromARGB(255, 242, 238, 236),
      fontSize: 22,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textPageSubTitleStyle() {
    return const TextStyle(
      color: Color.fromARGB(127, 242, 238, 236),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textParagraphStyle() {
    return const TextStyle(
      color: CBColors.lava,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
  }

  static const TextStyle textLabelStyle = TextStyle(
    color: Color.fromARGB(127, 242, 238, 236),
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textLabelBrownStyle = TextStyle(
    color: CBColors.lava,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textHintStyle = TextStyle(
    color: Color.fromARGB(127, 242, 238, 236),
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static const TextStyle textParagraphWhiteStyle = TextStyle(
    color: Color.fromARGB(255, 242, 238, 236),
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static const TextStyle textParagraphWhite12Style = TextStyle(
    color: Color.fromARGB(255, 242, 238, 236),
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textParagraphWhite10Style = TextStyle(
    color: Color.fromARGB(255, 242, 238, 236),
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle textParagraphWhite15SemiBoldStyle = TextStyle(
    color: Color.fromARGB(255, 242, 238, 236),
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle textPageTitle18OrangeStyle = TextStyle(
    color: CBColors.redCrayola,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle text12MediumWhiteStyle = TextStyle(
    color: Color.fromARGB(255, 242, 238, 236),
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle text12BoldWhiteStyle = TextStyle(
    color: Color.fromARGB(255, 242, 238, 236),
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}
