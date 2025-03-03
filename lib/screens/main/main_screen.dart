import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/VerifyX/verify.dart';
import 'package:admin/screens/billpayments/billpayments.dart';
import 'package:admin/screens/contacts/contacts.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/history/history.dart';
import 'package:admin/screens/login.dart';
import 'package:admin/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _showChatWindow = false;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _navigateTo(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(onMenuTap: _navigateTo),
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: SideMenu(onMenuTap: _navigateTo),
                  ),
                Expanded(
                  flex: 5,
                  child: Navigator(
                    key: _navigatorKey,
                    initialRoute: '/dashboard',
                    onGenerateRoute: (settings) {
                      Widget page;
                      switch (settings.name) {
                        case '/dashboard':
                          page = DashboardScreen();
                          break;
                        case '/contacts':
                          page = Contacts();
                          break;
                        case '/billpayments':
                          page = BillPayments();
                          break;
                          case '/Verify':
                          page = VerifyScreen();
                          break;
                           case '/Login':
                          page = Login();
                          break;
                           case '/Verify':
                          page = VerifyScreen();
                          break;
                               case '/history':
                          page = TransactionHistory();
                          break;
                             case '/settings':
                          page = Setting();
                          break;
                        default:
                          page = DashboardScreen();
                      }
                      return MaterialPageRoute(builder: (_) => page);
                    },
                  ),
                ),
              ],
            ),
            // Chat Window
            if (_showChatWindow)
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: Container(
                  width: 300.0,
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Live Chat',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _showChatWindow = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10, // Replace with your chat messages
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Message ${index + 1}'),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Type a message...',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                // TODO: Implement send message functionality
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Floating Chat Button
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _showChatWindow = !_showChatWindow;
                  });
                },
                child: Icon(Icons.chat),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
