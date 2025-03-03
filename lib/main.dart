import 'package:admin/constants.dart';
import 'package:admin/controllers/cashfreeauth.dart';
import 'package:admin/controllers/login_controller.dart';
import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/screens/login.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Ensure Firebase initialization
  Get.put(LoginController());
  AuthController().getTokenAndSave();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payouts',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: const Color.fromARGB(255, 0, 0, 0)),
        canvasColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in, navigate to MainScreen
      Get.offAll(() => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuAppController(),
              ),
            ],
            child: MainScreen(),
          ));
    } else {
      // User is not logged in, navigate to LoginPage
      Get.offAll(() => Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'logo.png', // Replace with your logo path
              height: 100,
              width: 200,
            ),
            Lottie.asset(
              'splash.json', // Path to your Lottie animation file
              height: 20,
              width: 250,
            ),
            SizedBox(height: 200),
            Container(
              height: 40,
              width: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text('Payouts'),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_circle_right_outlined, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
