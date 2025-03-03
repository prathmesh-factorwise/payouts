import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


const Color secondaryColor = Color(0xFFEDEDED);

class StorageDetails extends StatefulWidget {
  const StorageDetails({Key? key}) : super(key: key);

  @override
  _StorageDetailsState createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  // Map of billers for each category
  final Map<String, List<String>> billersByCategory = {
    'Postpaid': ['Airtel', 'Jio', 'Vi', 'BSNL', 'MTNL', 'Tata Teleservices', 'Wiwanet'],
    'Water': ['City Water', 'Rural Water Supply'],
    'Electricity': ['Tata Power', 'Adani Electricity'],
    'Prepaid': ['Airtel Prepaid', 'Jio Prepaid', 'Vi Prepaid'],
    'Landline': ['BSNL Landline', 'MTNL'],
    'FASTag': ['ICICI FASTag', 'HDFC FASTag'],
    'DTH': ['Tata Sky', 'Airtel Digital TV'],
    'Gas': ['Indane Gas', 'Bharat Gas'],
    'Rent': ['NoBroker', 'MagicBricks'],
  };
  TextEditingController phoneController = TextEditingController();

  // Add this to your StatefulWidget's state
String? selectedCircle; // Variable to store selected circle
List<String> circles = ['Maharashta', 'Delhi', 'Kolkata', 'Mumbai', 'Bangalore', 'Chennai', 'Chattisgarh','Gujrat','Bihar','Karnataka','Rajasthan']; // Circle dropdown options


  // Selected values
  String? selectedCategory;
  String? selectedBiller;
  final TextEditingController accountNameController = TextEditingController();

  // Conditional fields
  Widget getConditionalFields() {
    if (selectedCategory == 'Postpaid') {
      return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: InputDecoration(labelText: 'Circle'),
            items: ['Delhi', 'Mumbai', 'Bangalore', 'Chennai']
                .map((circle) => DropdownMenuItem<String>(
                      value: circle,
                      child: Text(circle),
                    ))
                .toList(),
            onChanged: (value) {},
          ),
        ],
      );
    } else if (selectedCategory == 'Water') {
      return TextFormField(
        decoration: InputDecoration(labelText: 'Consumer Number'),
      );
    } else if (selectedCategory == 'Electricity') {
      return TextFormField(
        decoration: InputDecoration(labelText: 'Meter Number'),
      );
    }
    return SizedBox.shrink(); // Empty container if no condition matches
  }
void openModal(String category) {
  setState(() {
    selectedCategory = category;
    selectedBiller = null; // Reset biller on category change
  });

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      PageController pageController = PageController();

      // Page 2 Data
      String outstandingAmount = "₹ 987";
      String dueDate = "15th December 2024";

      // Page 4 Data
      TextEditingController otpController = TextEditingController();

      return Center(
        child: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: StatefulBuilder(
              builder: (context, setModalState) {
                bool isLoading = false;

                // Function for timed button action
                Future<void> timedNextAction(VoidCallback onComplete) async {
                  setModalState(() => isLoading = true);
                  await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                  setModalState(() => isLoading = false);
                  onComplete();
                }

                return Container(
                  margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // PageView for Navigation
                          SizedBox(
                            height: 400, // Fixed modal height
                            child: PageView(
                              controller: pageController,
                              physics: NeverScrollableScrollPhysics(), // Disable swipe
                              children: [
                                // Page 1: Account Details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildLogo(),
                                    SizedBox(height: 12),
                                    Center(
                                      child: Text(
                                        'Enter Billing Details',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    TextFormField(
                                      controller: accountNameController,
                                      decoration: inputDecoration('Account Name'),
                                    ),
                                    SizedBox(height: 16),
                                    DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      value: selectedCategory,
                                      decoration: inputDecoration('Category').copyWith(
                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                                      ),
                                      items: billersByCategory.keys
                                          .map((category) => DropdownMenuItem<String>(
                                                value: category,
                                                child: Text(category, style: TextStyle(color: Colors.black)),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setModalState(() {
                                          selectedCategory = value;
                                          selectedBiller = null;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
  isExpanded: true,
  value: selectedBiller,
  decoration: inputDecoration('Biller').copyWith(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
  ),
  dropdownColor: Colors.grey[200],  // Set background color to grey when expanded
  items: (billersByCategory[selectedCategory] ?? [])
      .map((biller) => DropdownMenuItem<String>(
            value: biller,
            child: Text(biller, style: TextStyle(color: Colors.black)),
          ))
      .toList(),
  onChanged: (value) {
    setModalState(() => selectedBiller = value);
  },
),

                                    SizedBox(height: 16),
                                 TextFormField(
  controller: phoneController, // Define this controller to handle the input
  decoration: inputDecoration('Phone Number').copyWith(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
  ),
  keyboardType: TextInputType.phone,  // This sets the input type to phone number
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,  // Ensure only numbers can be entered
    LengthLimitingTextInputFormatter(10),  // Limit input to 10 digits (for phone numbers)
  ],
),

                                    SizedBox(height: 24),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: blueButton(
                                        'Fetch',
                                        isLoading,
                                        () => timedNextAction(() {
                                          pageController.nextPage(
                                              duration: Duration(milliseconds: 300), curve: Curves.ease);
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                // Page 2: Outstanding Bill
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildLogo(),
                                    SizedBox(height: 16),
                                    Text(
                                      'Outstanding Bill Details',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 16),
                                    Text("Outstanding Amount:                                                                                                            $outstandingAmount",
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 8),
                                    Text("Due Date:                                                                                                     $dueDate", style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 60),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: blueButton(
                                        'Pay',
                                        isLoading,
                                        () => timedNextAction(() {
                                          pageController.nextPage(
                                              duration: Duration(milliseconds: 300), curve: Curves.ease);
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                // Page 3: Payment Method
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildLogo(),
                                    SizedBox(height: 16),
                                    Text(
                                      'Select Payment Method',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 16),
                                    RadioListTile(
                                      title: Text("Wallet"),
                                      value: "Wallet",
                                      groupValue: "Wallet",
                                      onChanged: (value) {},
                                      activeColor: const Color.fromARGB(255, 12, 2, 125),
                                    ),
                                    SizedBox(height: 150),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: blueButton(
                                        'Proceed',
                                        isLoading,
                                        () => timedNextAction(() {
                                          pageController.nextPage(
                                              duration: Duration(milliseconds: 300), curve: Curves.ease);
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                // Page 4: OTP Verification
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildLogo(),
                                    SizedBox(height: 16),
                                    Text(
                                      'OTP Verification',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: List.generate(6, (index) {
                                        return SizedBox(
                                          width: 30,
                                          child: TextFormField(
                                            controller: otpController,
                                            decoration: inputDecoration('OTP'),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                    ),
                                    SizedBox(height: 160),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: blueButton(
                                        'Submit',
                                        isLoading,
                                        () => timedNextAction(() {
                                          Navigator.pop(context);
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            radius: 14,
                            child: Icon(Icons.close, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

Widget buildLogo() {
  return Align(
    alignment: Alignment.topLeft,
    child: Image.asset("assets/icons/bbps.png", height: 50, width: 50),
  );
}

InputDecoration inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)),
  );
}

Widget blueButton(String text, bool isLoading, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: isLoading ? null : onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 9, 8, 111),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: isLoading
        ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white))
        : Text(text),
  );
}








  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Title and Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bill Payments",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/bharatconnect.svg", // Add your logo here
                height: 32,
                width: 32,
              ),
            ],
          ),
          SizedBox(height: defaultPadding),

          // Bill Payments & Recharge Section
          _buildSectionTitle("Bill Payments & Recharge"),
          _buildButtonRow([
            _buildPaymentButton("Prepaid", "assets/icons/mobile.jpg"),
            _buildPaymentButton("Landline", "assets/icons/telephone.png"),
            _buildPaymentButton("FASTag", "assets/icons/fastag.png"),
            _buildPaymentButton("Postpaid", "assets/icons/mobile.jpg"),
            _buildPaymentButton("DTH", "assets/icons/dth.png"),
            _buildPaymentButton("Cable TV", "assets/icons/tv.png"),
             _buildPaymentButton("Broadband", "assets/icons/broadband.png"),
            
          ]),
          SizedBox(height: 25),

          // Utility Payments Section
          _buildSectionTitle("Utility Payments"),
          _buildButtonRow([
            _buildPaymentButton("Water", "assets/icons/water.png"),
            _buildPaymentButton("Electricity", "assets/icons/electricity.png"),
            _buildPaymentButton("Rent", "assets/icons/rent.png"),
            _buildPaymentButton("Gas", "assets/icons/gas.png"),
          ]),
          SizedBox(height: 25),

          _buildSectionTitle("Financial Services"),
          _buildButtonRow([
            _buildPaymentButton("Cards", "assets/icons/credit.png"),
            _buildPaymentButton("Insurance", "assets/icons/insurance.png"),
            _buildPaymentButton("Deposit ", "assets/icons/deposit.png"),
            _buildPaymentButton("Taxes", "assets/icons/tax.png"),
            _buildPaymentButton("Loan", "assets/icons/loan.png"),
          ]),
          SizedBox(height: 25),

                    _buildSectionTitle("Other Payments"),
          _buildButtonRow([
            _buildPaymentButton("Clubs", "assets/icons/club.png"),
            _buildPaymentButton("Hospital", "assets/icons/hospital.png"),
            _buildPaymentButton("Society", "assets/icons/society.png"),
            _buildPaymentButton("Municipalty", "assets/icons/municipal.png"),
          ]),
        ],
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // Button Row
  Widget _buildButtonRow(List<Widget> buttons) {
    return Wrap(
      spacing: 28,
      runSpacing: 15,
      children: buttons,
    );
  }

  // Payment Button
  Widget _buildPaymentButton(String label, String iconPath) {
    return GestureDetector(
      onTap: () => openModal(label), // Open modal popup
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                height: 24,
                width: 24,
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
