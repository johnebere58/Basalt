import 'package:basalt/basalt.dart';

extension NumExtensions on num{

   Widget get asWidth=>SizedBox(width: double.parse(toString()));

   Widget get asHeight=>SizedBox(height: double.parse(toString()));

   TextStyle asTextStyle(bool bold,{Color color=Colors.black87})=>TextStyle(fontSize: (double.parse(toString())),fontWeight: bold?FontWeight.bold:FontWeight.normal,
   color: color,);

}