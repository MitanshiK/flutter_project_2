import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_2/caching/controllers/local_database.dart';
import 'package:flutter_project_2/caching/views/home.dart';
import 'package:flutter_project_2/others/charts/chart1.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
void main() async {
    // dependency injection
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.createDatabase(); //creating database for storing news

  await Firebase.initializeApp();

// for webview start
  late final PlatformWebViewControllerCreationParams params;
if (WebViewPlatform.instance is WebKitWebViewPlatform) {
  params = WebKitWebViewControllerCreationParams(
    allowsInlineMediaPlayback: true,
    mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
  );
} else {
  params = const PlatformWebViewControllerCreationParams();
}

final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
// ···
if (controller.platform is AndroidWebViewController) {
  AndroidWebViewController.enableDebugging(true);
  (controller.platform as AndroidWebViewController)
      .setMediaPlaybackRequiresUserGesture(false);
}
// for webview end
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // to restrict change in orientation
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caching',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    );
  }
}

