import 'package:admin/controllers/cashfreeauth.dart';
import 'package:admin/controllers/directtransfer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constants.dart';
import 'package:admin/responsive.dart';
import 'package:file_picker/file_picker.dart';


class VirtualAccount extends StatelessWidget {
  const VirtualAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Account",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 1 : 2,
            childAspectRatio: _size.width < 650 ? 1.8 : 1.3,
          ),
          tablet: FileInfoCardGridView(crossAxisCount: 2, childAspectRatio: 1.3),
          desktop: FileInfoCardGridView(
            crossAxisCount: 3,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.45,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = AuthController();
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3, // Increased item count to 3 to include the add account card
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return FileInfoCard(
            title: "Virtual Account",
            balance: "₹0.00",
            details: [
              {"label": "Account Number", "value": "77222XXXXX"},
              {"label": "IFSC Code", "value": "UTIB0000XXX"},
            ],
            color: Colors.purple[100]!,
          );
        } else if (index == 1) {
          return FileInfoCard(
            title: "Wallet Balance",
            balance: "₹24.00",
            details: [
              {"label": "Today", "value": "₹0.00"},
              {"label": "Successful Transactions", "value": "0"},
            ],
            color: Colors.orange[100]!,
          );
        } else {
          // Add Account Card
          return InkWell(
            onTap: () {
              // TODO: Add logic to navigate to add account screen
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Instant Payout Button
                  ElevatedButton.icon(
                    onPressed: () async {
                      _showInstantPayoutDialog(context);
                      await  _authController.getTokenAndSave();
                      
                      
                    },
                    icon: Icon(Icons.payment_rounded, size: 24),
                    label: Text("Instant Payout", style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 37, 64, 155),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),

                  // To Beneficiary Button
                  ElevatedButton.icon(
                    onPressed: () {
                      _showBeneficiaryDialog(context);
                    },
                    icon: Icon(Icons.person, size: 24),
                    label: Text("To Beneficiary", style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 37, 64, 155),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Batch Transfer Button
                  ElevatedButton.icon(
                    onPressed: () {
                      _showBatchTransferDialog(context);
                    },
                    icon: Icon(Icons.table_chart_outlined, size: 24),
                    label: Text("Batch Transfer", style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 37, 64, 155),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Function to show Instant Payout Dialog
void _showInstantPayoutDialog(BuildContext context) {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  final DirectTransferController _directTransferController = DirectTransferController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog( backgroundColor: const Color.fromARGB(255, 235, 246, 255),
        
        content: SingleChildScrollView(
          child: Container( height: 450,width: 550,
          child: (Column(
            children: [ Image.asset( "images/payout.png", height: 100, width: 700),
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.only(left: 10.0),),
            Form(
            key: _formKey,
            child: Column(
              children: [
                // Name field
                TextFormField(
                  controller: _nameController,
                      decoration: InputDecoration(
                    labelText: 'Name',
                 labelStyle: TextStyle(color: Colors.black), // Label text color
                  ),
          style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                
                // Email field
                TextFormField(
                  controller: _emailController,
                                    decoration: InputDecoration(
    labelText: 'Email',
    labelStyle: TextStyle(color: Colors.black), // Label text color
  ),
  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                
                // Phone field
                TextFormField(
                  controller: _phoneController,
                    decoration: InputDecoration(
    labelText: 'Phone',
    labelStyle: TextStyle(color: Colors.black), // Label text color
  ),
  style: TextStyle(color: Colors.black),
                  
                  
                  keyboardType: TextInputType.phone,
                   
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (value.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                
                // Bank Account field
                TextFormField(
                  controller: _bankAccountController,
                                    decoration: InputDecoration(
    labelText: 'Bank Account Number',
    labelStyle: TextStyle(color: Colors.black), // Label text color
  ),
  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bank account number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                
                // IFSC code field
                TextFormField(
                  controller: _ifscController,
                                    decoration: InputDecoration(
    labelText: 'IFSC code',
    labelStyle: TextStyle(color: Colors.black), // Label text color
  ),
  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your IFSC code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                
                // Amount field
                TextFormField(
                  controller: _amountController,
                                    decoration: InputDecoration(
    labelText: 'Amount',
    labelStyle: TextStyle(color: Colors.black), // Label text color
  ),
  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the transfer amount';
                    } else if (double.tryParse(value) == null) {
                      return 'Enter a valid amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
              
            ]))
        ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red),),
          ),
          ElevatedButton( 
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Get the values from the controllers
                String name = _nameController.text;
                String email = _emailController.text;
                String phone = _phoneController.text;
                String bankAccount = _bankAccountController.text;
                String ifsc = _ifscController.text;
                String amount = _amountController.text;

                // Call the controller method to initiate the transfer
                _directTransferController.initiateDirectTransfer(
                  name: name,
                  email: email,
                  phone: phone,
                  bankAccount: bankAccount,
                  ifsc: ifsc,
                  amount: amount,
                );

                Navigator.of(context).pop(); // Close the dialog
              };
              _showConfirmDialog(context);
              
            },
            child: Text('Proceed', style: TextStyle(color: Colors.white),),
          ),
        ],
      ); 
    },
  );
}

void _showBeneficiaryDialog(BuildContext context) {
  int _currentStep = 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 235, 246, 255),
            title: Text(
              _currentStep == 0 ? 'Select Beneficiary' : 'Transfer Details',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            content: SingleChildScrollView(
              child: _currentStep == 0
                  ? Column(
                      children: [
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Select Beneficiary'),
                          items: [
                            DropdownMenuItem(
                              child: Text('Beneficiary 1'),
                              value: 'beneficiary1',
                            ),
                            DropdownMenuItem(
                              child: Text('Beneficiary 2'),
                              value: 'beneficiary2',
                            ),
                          ],
                          onChanged: (value) {
                            // Store selected beneficiary
                            setState(() => _currentStep = 1); // Move to next step
                          },
                        ),
                      ],
                    )
                  : Column( // Step 2: Amount & Transfer Mode
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Transfer Mode'),
                          items: [
                            DropdownMenuItem(child: Text('NEFT'), value: 'neft'),
                            DropdownMenuItem(child: Text('IMPS'), value: 'imps'),
                          ],
                          onChanged: (value) {
                            // Store selected transfer mode
                          },
                        ),
                      ],
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_currentStep == 1) {
                    setState(() => _currentStep = 0); // Go back to previous step
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(_currentStep == 0? 'Cancel' : 'Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_currentStep == 0) {
                     //If no beneficiary is selected
                    return;
                  } else {
                    // Handle the proceed action – transfer funds here
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Proceed'),
              ),
            ],
          );
        },
      );
    },
  );
}


void _showConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 235, 246, 255),
        content: SingleChildScrollView(
          child: Container(
            height: 500,
            width: 550,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
              children: [
                Lottie.asset(
                  'assets/images/confirm.json',
                  height: 100,
                ), // Lottie animation in the center
                const SizedBox(height: 20), // Add spacing between elements
                const Text(
                  "Your payout has been triggered successfully!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Amount: ₹1",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Charges: ₹2.5",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}




  // Function to show Batch Transfer Dialog
void _showBatchTransferDialog(BuildContext context) {
  String? _selectedFileName;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: const Color.fromARGB(255, 244, 247, 255),
        title: Row(
          children: [
            Icon(Icons.cloud_upload, color: const Color.fromARGB(255, 0, 28, 50)),
            SizedBox(width: 8),
            Text(
              'Batch Transfer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upload an Excel file for batch transfer of payments.',
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xlsx', 'xls'],
                  );

                  if (result != null) {
                    _selectedFileName = result.files.single.name;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('File Selected: $_selectedFileName'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // User canceled the picker
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('File selection canceled'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.upload_file),
                label: Text('Pick Excel File'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (_selectedFileName != null) ...[
                SizedBox(height: 20),
                Text(
                  'Selected File:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _selectedFileName!,
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedFileName != null) {
                // Handle the proceed action
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Processing file: $_selectedFileName'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please select a file before proceeding'),
                  ),
                );
              }
            },
            child: Text('Proceed'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      );
    },
  );
}}

class FileInfoCard extends StatelessWidget {
  final String title;
  final String balance;
  final List<Map<String, String>> details;
  final Color color;

  const FileInfoCard({
    Key? key,
    required this.title,
    required this.balance,
    required this.details,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            balance,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
          ),
          SizedBox(height: defaultPadding),
          for (var detail in details)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    detail["label"]!,
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    detail["value"]!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
