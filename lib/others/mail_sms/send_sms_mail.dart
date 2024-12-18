import 'package:flutter/material.dart';
import 'package:flutter_project_2/others/octa_image_class.dart';
import 'package:url_launcher/url_launcher.dart';

// code added to manifest in android and info.plist in ios
class SendSmsAndMail extends StatefulWidget {
  const SendSmsAndMail({super.key});

  @override
  State<SendSmsAndMail> createState() => _SendSmsAndMailState();
}

class _SendSmsAndMailState extends State<SendSmsAndMail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController numController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const OctaImageClass()));
        }, icon: const Icon(Icons.next_plan))],
        title: const Text(" Send SMS or Mail"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              maxLines: 1,
              decoration: const InputDecoration(
                  label: Text(" Enter email"), hintText: "abc@gmail.com"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  sendMailFun();
                },
                child: const Text("Send Mail")),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: numController,
              maxLines: 1,
              decoration: const InputDecoration(
                  label: Text(" Enter Phone Number"), hintText: "1234567897"),
            ),
            const SizedBox(
              height: 15,
            ),
            RotatedBox(
              quarterTurns: 1, // rotates specified number of turns anti-clockwise
              child: ElevatedButton(
                  onPressed: () {
                    sendSmsFun();
                  },
                  child: const Text("Send SMS")),
                
            )
          ],
        ),
      ),
    );
  }

  sendMailFun() async {
    // var url = Uri.parse("mailto:${emailController.text}"+"subject: Testing subject");
    //OR
    String body="[name] is inviting you to join chat app and chat";
  var url = Uri(
      scheme: 'mailto',
      path: emailController.text,
      queryParameters: {
        'subject': "Invitation",
        'body'  : body
      },
    ).toString().replaceAll("+", "%20");      // so that spaces in the body and subject do not get replaced with +   

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("could not launch the url[mail]");
    }
  }

  sendSmsFun() async {
  //  var url = Uri.parse("sms:${numController.text}");
  //OR
   var url = Uri(
      scheme: 'sms',
      path: numController.text,
      queryParameters: {
        'body'  : "[name] is inviting you to join Chat App and chat"
      },
    ).toString().replaceAll("+", "%20");
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
     print("could not launch the url[phone]");
  }
  }
}
