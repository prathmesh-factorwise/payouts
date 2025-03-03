import 'package:flutter/material.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import '../../constants.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Map<String, String>> contacts = [];
  List<Map<String, String>> filteredContacts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
  }

  void filterContacts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredContacts = contacts.where((contact) {
        return contact.values.any((value) =>
            value.toLowerCase().contains(searchQuery));
      }).toList();
    });
  }

  void addContact(String name, String email, String phone, String account, String ifsc) {
    setState(() {
      contacts.add({
        "Name": name,
        "Email": email,
        "Phone": phone,
        "Bank Account": account,
        "IFSC": ifsc,
      });
      filteredContacts = contacts;
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
            Header(activePageTitle: 'Contacts'),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(  // Added SizedBox to limit width
                  width: 400, // Set your desired width here
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by Name, Email, or Bank Account",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: filterContacts,
                  ),
                ),

                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color.fromARGB(255, 0, 28, 50),
    ),
  ),
                  icon: Icon(Icons.add),
                  label: Text("Create Contact"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => CreateContactDialog(
                        onSave: addContact,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            buildContactsTable(),
          ],
        ),
      ),
    );
  }


  Widget buildContactsTable() {
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
            "Contacts",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: defaultPadding),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("Phone")),
                DataColumn(label: Text("Bank Account")),
                DataColumn(label: Text("IFSC")),
              ],
              rows: filteredContacts.map((contact) {
                return DataRow(cells: [
                  DataCell(Text(contact["Name"]!)),
                  DataCell(Text(contact["Email"]!)),
                  DataCell(Text(contact["Phone"]!)),
                  DataCell(Text(contact["Bank Account"]!)),
                  DataCell(Text(contact["IFSC"]!)),
                ]);
              }).toList(),
            ),
          ),
          if (filteredContacts.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "No Contacts Found",
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CreateContactDialog extends StatelessWidget {
  final Function(String, String, String, String, String) onSave;

  CreateContactDialog({required this.onSave});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();

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
              "Create Contact",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: defaultPadding),
            buildTextField("Name", nameController),
            SizedBox(height: defaultPadding / 2),
            buildTextField("Email ID", emailController),
            SizedBox(height: defaultPadding / 2),
            buildTextField("Phone Number", phoneController),
            SizedBox(height: defaultPadding / 2),
            buildTextField("Bank Account", accountController),
            SizedBox(height: defaultPadding / 2),
            buildTextField("IFSC Code", ifscController),
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
                    onSave(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      accountController.text,
                      ifscController.text,
                    );
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

  Widget buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
