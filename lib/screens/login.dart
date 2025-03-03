
import 'package:admin/comman/colors.dart';
import 'package:admin/controllers/login_controller.dart';
import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  final LoginController controller = Get.find<LoginController>();
  bool valuefirst = false;

  final GlobalKey<FormState> rowFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> columnFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: width > 750 ? row(context, height, width) : column(context, height),
      backgroundColor: const Color.fromARGB(255, 243, 248, 252),
    );
  }

Form row(BuildContext context, double height, double width) {
  return Form(
    key: rowFormKey,
    child: Center(
      child: Container(
        height: 450,
        width: 900,
        decoration: BoxDecoration(     borderRadius: BorderRadius.circular(8.0), 
          color: Colors.white, // Container background color
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: width > 880 ? 1 : width > 750 ? 2 : 3,
              child: imageLogin(context),
            ),
            Expanded(
              flex: width > 880 ? 1 : width > 750 ? 1 : 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    loginFields(width),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}




SingleChildScrollView column(BuildContext context, double height) {
  return SingleChildScrollView(
    physics: const ScrollPhysics(),
    child: Form(
      key: columnFormKey,
      child: SizedBox(  // Use SizedBox to constrain the size
        width: MediaQuery.of(context).size.width * 0.5, // Example: 80% of screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              
              child: Row(
                children: [
                  imageLogin(context),
                  loginFields(height),
                  
                ],
              ),
              
            ),
          ],
        ),
      ),
    ),
  );
}



  Container loginFields(height) {
    return Container(
      height: 470,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoginText(
                  color: AppColor.darkblack,
                  fontWeight: FontWeight.w800,
                  size: 20,
                  text: "Payouts",
                ),
              ],
            ),

     
            Container(height: 8),
            LoginText(
              color: AppColor.lightdark,
              text: "Sign in to continue to Budgetree.",
              size: 14,
              fontWeight: FontWeight.w500,
            ),
            Container(height: 27),
            Align(
              alignment: Alignment.centerLeft,
              child: LoginText(
                text: "Email",
                size: 9,
                color: AppColor.dark,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(height: 10),
         SizedBox(
  height: 38, // Set your desired height here
  child: TextFormField(
    controller: controller.emailController,
    decoration: InputDecoration(
      hintText: 'Enter email',
      hintStyle: TextStyle(color: AppColor.hintcolor, fontSize: 14),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.borders, width: 1),
      ),
    ),
  ),
),

            Container(height: 17),
            Row(
              children: [
                LoginText(
                  text: "Password",
                  size: 12,
                  color: AppColor.dark,
                  fontWeight: FontWeight.w500,
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () => Get.to(() => DashboardScreen()),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: LoginText(
                        text: "Forgot password?",
                        size: 14,
                        color: AppColor.lightgrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Container(
              height: 40,
              child: Obx(() => TextFormField(
                    obscureText: controller.isShow.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.hintcolor,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.isShow.value = !controller.isShow.value;
                        },
                        child: Container(
                          color: AppColor.boxborder,
                          width: 50,
                          child: Icon(
                            controller.isShow.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 18,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      isDense: true,
                      hintText: "Enter password",
                      hintStyle: TextStyle(
                        color: AppColor.hintcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.borders, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.borders),
                      ),
                    ),
                  )),
            ),
            Container(height: 17),
            Row(
              children: [
                Checkbox(
                  side: BorderSide(color: AppColor.hintcolor),
                  fillColor: MaterialStatePropertyAll(
                    valuefirst == true
                        ? AppColor.selecteColor
                        : AppColor.mainbackground,
                  ),
                  value: valuefirst,
                  onChanged: (value) {
                    setState(() {
                      valuefirst = value!;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: LoginText(
                    text: "Remember me",
                    size: 12,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(height: 25),
            InkWell(
              onTap: () {
        
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: const Color.fromARGB(255, 60, 0, 255)),
                        ],
                        borderRadius: BorderRadius.circular(4),
                        color: const Color.fromARGB(255, 0, 43, 143),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: LoginText(
                          text: "Log in",
                          size: 14,
                          color: AppColor.mainbackground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          


             
            ],
          ),
        ));
  }
}

class AuthFields extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  AuthFields({required this.hint, required this.obscure, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      
      child: TextFormField(
        obscureText: obscure,
        initialValue: "",
        style: TextStyle(
          fontSize: 14,
          color: AppColor.hintcolor,
          fontWeight: FontWeight.w400,
        ),
        autocorrect: true,
        decoration: InputDecoration(
          isDense: true,
          // fillColor: AppColor.mainbackground,
          hintText: hint,
          hintStyle: TextStyle(
              color: AppColor.hintcolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        
          enabledBorder: OutlineInputBorder(

            borderSide: BorderSide(color: AppColor.borders, width: 1),
          ),
          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(color: AppColor.borders),
          ),
        ),
      ),
    );
  }
}

Stack imageLogin(BuildContext context) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          "images/Login1.png",
          fit: BoxFit.fill,
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                    // color: Colors.amber,
                    width: 787,
                    height: 400,
                    ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class LoginText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double size;

  const LoginText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.fade,
      softWrap: false,
      // textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
