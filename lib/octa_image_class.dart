import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class OctaImageClass extends StatefulWidget {
  const OctaImageClass({super.key});

  @override
  State<OctaImageClass> createState() => _OctaImageClassState();
}

class _OctaImageClassState extends State<OctaImageClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OctaImage"),),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //  SizedBox(
            //   height: 200,
            //   width: 200,
            //    child: OctoImage(
            //          image: const NetworkImage(
            //              'https://firebasestorage.googleapis.com/v0/b/flutter1-a89ae.appspot.com/o/ProfilePictures%2F26378990-670a-1067-80c1-6bb7cd4bcf3a?alt=media&token=414b0197-444d-4ee8-b423-d763f15e832c'),
            //          placeholderBuilder: OctoPlaceholder.circleAvatar(backgroundColor: Colors.blue, text: const Text("loading")) ,
            //          errorBuilder: OctoError.icon(color: Colors.red),
            //          fit: BoxFit.cover,
            //        ),
            //  ),
             SizedBox(height: 30,),
             SizedBox(
    height: 200,
    width: 200,
    child: OctoImage(
      image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/flutter1-a89ae.appspot.com/o/ProfilePictures%2F26378990-670a-1067-80c1-6bb7cd4bcf3a?alt=media&token=414b0197-444d-4ee8-b423-d763f15e832c'),
      progressIndicatorBuilder: (context, progress) {
        double value;
        if (progress != null && progress.expectedTotalBytes != null) {
          value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes!;
        }
        else{
          value=0;
        }
        return CircularProgressIndicator(value: value);
      },
      errorBuilder: (context, error, stacktrace) => Icon(Icons.error),
    ),
  )
          ],
        ),),
    );
  }
}