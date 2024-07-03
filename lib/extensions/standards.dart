import 'package:dar_nashr_gameat_el_malek_soad/extensions/extensions.dart';
import 'package:flutter/material.dart';

/////////// Colors //////////////
Color primaryColor = const Color(0xff0083BC);
Color secondryColor = const Color.fromARGB(255, 110, 145, 160);
Color backgroundColor = const Color(0xffF0F1F1);
Color disabledButtonColor = const Color.fromARGB(255, 179, 182, 184);
Color enabledButtonColor = const Color.fromARGB(255, 162, 196, 218);
Color disabledButtonColorDark = const Color.fromARGB(255, 90, 95, 98);
Color enabledButtonColorDark = const Color.fromARGB(255, 4, 19, 31);

Color white = const Color(0xffFFFFFF);
Color black = const Color(0xff000000);
Color backgroundColorDark = const Color(0xff012638);
Color secondryColorDark = const Color.fromARGB(255, 32, 60, 90);
Color goldColor = const Color(0xffFAA64A);

/////////// Fonts //////////////

/////////// widgets //////////////
Widget divederConst() {
  return Container(
      margin: const EdgeInsets.only(top: 60),
      child: Divider(
        color: primaryColor,
      ));
}

Widget headerStyle(String headerText, {double headerFont = 35}) {
  return Padding(
    padding: const EdgeInsetsDirectional.symmetric(vertical: 40),
    child: Text(
      headerText.capitalizeByWord(),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: headerFont,
      ),
    ),
  );
}
