import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
   
  ColorsApp._();
  static ColorsApp get instance{
    _instance??=  ColorsApp._();
    return _instance!;
   }

   Color get primaryColor => const Color(0xff007d21);
   Color get secondaryColor => const Color(0xffffab18);
   Color get blackColor => const Color(0xff140e0e);
}


extension ColorsAppExtension on BuildContext {
  Color get primaryColor => ColorsApp.instance.primaryColor;
  Color get secondaryColor => ColorsApp.instance.secondaryColor;
  Color get blackColor => ColorsApp.instance.blackColor;
}