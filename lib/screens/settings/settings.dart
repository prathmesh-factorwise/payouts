import 'package:flutter/material.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import '../../constants.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(activePageTitle: 'Settings'),
            SizedBox(height: defaultPadding),
            buildSection(context, "Personal Information", buildPersonalInfoSection()),
            SizedBox(height: defaultPadding),
            buildSection(context, "Business Information", buildBusinessInfoSection()),
            SizedBox(height: defaultPadding),
            buildSection(context, "Security", buildSecuritySection(context)),
            SizedBox(height: defaultPadding),
            buildSection(context, "Billing", buildBillingSection(context)),
          ],
        ),
      ),
    );
  }

  Widget buildSection(BuildContext context, String title, Widget content) {
    return Container(
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: defaultPadding),
          content,
        ],
      ),
    );
  }

  Widget buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow("Name", "Prathmesh Gaikwad"),
        SizedBox(height: 10),
        buildInfoRow("Email", "prathmesh@budgetreecs.com"),
        SizedBox(height: 10),
        buildInfoRow("Phone", "+123 456 7890"),
      ],
    );
  }

  Widget buildBusinessInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow("Business Name", "Factorcard Services PVT Limited"),
        SizedBox(height: 10),
        buildInfoRow("Tax ID", "123-456-789"),
        SizedBox(height: 10),
        buildInfoRow("Address", "123 Business St, City, Country"),
      ],
    );
  }

  Widget buildSecuritySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ChangePasswordDialog(),
            );
          },
          child: Text("Change Password"),
        ),
      ],
    );
  }

  Widget buildBillingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow("Pending Invoice", "\Rs 0"),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => PricingDialog(),
            );
          },
          child: Text("View Pricing Details"),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}

class ChangePasswordDialog extends StatelessWidget {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Change Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: defaultPadding),
            buildTextField("Current Password", currentPasswordController, true),
            SizedBox(height: defaultPadding),
            buildTextField("New Password", newPasswordController, true),
            SizedBox(height: defaultPadding),
            buildTextField("Confirm Password", confirmPasswordController, true),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add change password logic here
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class PricingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pricing Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: defaultPadding),
         
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
