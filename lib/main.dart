import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_2/charts/chart1.dart';
import 'package:flutter_project_2/mail_sms/send_sms_mail.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();  
  SystemChrome.setPreferredOrientations(  [DeviceOrientation.portraitUp]);  // to restrict change in orientation

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Chart1(),
    );
  }
}
