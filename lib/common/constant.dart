import 'package:flutter/material.dart';

const String API_URL = "http://bss.mobwebit.com/api/AppAPI/";
const String IMAGE_URL = "http://bss.mobwebit.com";

const Inr_Rupee = "₹";

class Session {
  static const String session_login = "Login_data";
  static const String CourceId = "CourceId";
  static const String Id = "Id";
  static const String FatherName = "FatherName";
  static const String Name = "Member_Name";
  static const String FatherMobile = "FatherMobile";
  static const String MotherName = "MotherName";
  static const String MotherMobile = "MotherMobile";
  static const String JoinDate = "JoinDate";
  static const String BatchTime = "BatchTime";
  static const String RegNo = "RegNo";
  static const String Address = "Address";
  static const String PracticeType = "PracticeType";
  static const String CoachingType = "CoachingType";
  static const String Email = "Email";
  static const String Location= "Location";
  static const String IsActive= "IsActive";
  static const String Photo= "Photo";
}

Map<int, Color> appprimarycolors = {
  50: Color.fromRGBO(255,218,65, .1),
  100: Color.fromRGBO(255,218,65, .2),
  200: Color.fromRGBO(255,218,65, .3),
  300: Color.fromRGBO(255,218,65, .4),
  400: Color.fromRGBO(255,218,65, .5),
  500: Color.fromRGBO(255,218,65, .6),
  600: Color.fromRGBO(255,218,65, .7),
  700: Color.fromRGBO(255,218,65, .8),
  800: Color.fromRGBO(255,218,65, .9),
  900: Color.fromRGBO(255,218,65, 1)
};

Map<int, Color> FontColor = {
  50: Color.fromRGBO(42,53,101, .1),
  100: Color.fromRGBO(42,53,101, .2),
  200: Color.fromRGBO(42,53,101, .3),
  300: Color.fromRGBO(42,53,101, .4),
  400: Color.fromRGBO(42,53,101, .5),
  500: Color.fromRGBO(42,53,101, .6),
  600: Color.fromRGBO(42,53,101, .7),
  700: Color.fromRGBO(42,53,101, .8),
  800: Color.fromRGBO(42,53,101, .9),
  900: Color.fromRGBO(42,53,101, 1)
};

MaterialColor appPrimaryMaterialColor = MaterialColor(0xFFE1DA41, appprimarycolors);
MaterialColor  fontColors= MaterialColor(0xFF2A3565, FontColor);