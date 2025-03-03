import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  final Function(String) onMenuTap; // Callback function

  const SideMenu({
    Key? key,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 239, 242, 255),
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () => onMenuTap('/ashboard'),
          ),
          DrawerListTile(
            title: "Contacts",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => onMenuTap('/contacts'),
          ),
          DrawerListTile(
            title: "Bill Payments",
            svgSrc: "assets/icons/menu_task.svg",
            press: () => onMenuTap('/billpayments'),
          ),
          DrawerListTile(
            title: "Verify",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () => onMenuTap('/Verify'),
          ),
          DrawerListTile(
            title: "Payout History",
            svgSrc: "assets/icons/menu_store.svg",
            press: () => onMenuTap('/history'),
          ),
          DrawerListTile(
            title: "Notifications",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () => onMenuTap('/notifications'),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () => onMenuTap('/settings'),
          ),
            DrawerListTile(
            title: "Logout",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () async {
              await FirebaseAuth.instance.signOut();
      
            },
          ),
          const SizedBox(height: 100),
          Row(
            children: const [
              Icon(Icons.copyright_rounded, color: Colors.black, size: 15),
              Text(
                "  2024. All Rights Reserved.\n Budgetree Private Limited ",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(
          Color.fromARGB(135, 0, 0, 0),
          BlendMode.srcIn,
        ),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
