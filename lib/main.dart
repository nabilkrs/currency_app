import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:device_preview/device_preview.dart';
import 'home.dart';

void main() async{

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),)
    
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,

      debugShowCheckedModeBanner: false,
            
        
        home: Home(),
        
      );

  }
}