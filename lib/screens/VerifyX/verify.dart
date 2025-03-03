import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Add this dependency for a beautiful loader.
import '../../constants.dart';


class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  // Controllers for input fields
  final TextEditingController upiController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController gstController = TextEditingController();

  // State variables
  String? upiVerifiedName;
  String? bankVerifiedName;
  String? gstVerifiedName;
  bool isUPILoading = false;
  bool isBankLoading = false;
  bool isGSTLoading = false;

  Future<void> verifyUPI() async {
    setState(() {
      isUPILoading = true;
      upiVerifiedName = null;
    });

    // Simulate verification delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isUPILoading = false;
      upiVerifiedName = "Verified UPI Name: John Doe"; // Mock result
    });
  }

  Future<void> verifyBank() async {
    setState(() {
      isBankLoading = true;
      bankVerifiedName = null;
    });

    // Simulate verification delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isBankLoading = false;
      bankVerifiedName = "Verified Account Holder: Jane Smith"; // Mock result
    });
  }

  Future<void> verifyGST() async {
    setState(() {
      isGSTLoading = true;
      gstVerifiedName = null;
    });

    // Simulate verification delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isGSTLoading = false;
      gstVerifiedName = "Verified GST Name: ABC Pvt Ltd"; // Mock result
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(activePageTitle: 'Verify X'),
            SizedBox(height: 80),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: defaultPadding,
                    runSpacing: defaultPadding,
                    children: [
                      buildVerificationContainer(
                        title: "UPI Verification",
                        children: [
                          TextField(
                            controller: upiController,
                            decoration: InputDecoration(
                              labelText: "UPI ID",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          ElevatedButton(
                            onPressed: verifyUPI,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 0, 72, 138),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Verify UPI", style: TextStyle(fontSize: 16,color: Colors.white)),
                          ),
                          SizedBox(height: defaultPadding),
                          if (isUPILoading)
                            SpinKitCircle(color: const Color.fromARGB(255, 1, 10, 106), size: 50)
                          else if (upiVerifiedName != null)
                            Text(
                              upiVerifiedName!,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                      buildVerificationContainer(
                        title: "Bank Account Verification",
                        children: [
                          TextField(
                            controller: accountController,
                            decoration: InputDecoration(
                              labelText: "Account Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding / 2),
                          TextField(
                            controller: ifscController,
                            decoration: InputDecoration(
                              labelText: "IFSC Code",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          ElevatedButton(
                            onPressed: verifyBank,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 0, 72, 138),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Verify Bank", style: TextStyle(fontSize: 16,color:Colors.white)),
                          ),
                          SizedBox(height: defaultPadding),
                          if (isBankLoading)
                          SpinKitCircle(color: const Color.fromARGB(255, 1, 10, 106), size: 50)
                          else if (bankVerifiedName != null)
                            Text(
                              bankVerifiedName!,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                      buildVerificationContainer(
                        title: "GST Verification",
                        children: [
                          TextField(
                            controller: gstController,
                            decoration: InputDecoration(
                              labelText: "GST Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          ElevatedButton(
                            onPressed: verifyGST,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 0, 72, 138),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Verify GST", style: TextStyle(fontSize: 16,color: Colors.white)),
                          ),
                          SizedBox(height: defaultPadding),
                          if (isGSTLoading)
                           SpinKitCircle(color: const Color.fromARGB(255, 1, 10, 106), size: 50)
                          else if (gstVerifiedName != null)
                            Text(
                              gstVerifiedName!,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVerificationContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: 500,
      height: 300,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 72, 138),
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          Expanded(child: Column(children: children)),
        ],
      ),
    );
  }
}
