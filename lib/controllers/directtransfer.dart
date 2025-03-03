import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DirectTransferController {
  // API URL for direct transfer
  static const String directTransferUrl = 'http://54.144.118.156/api/v1/staging/payout/add-request-direct-transfer';

  // Function to generate a random transfer ID
  String generateTransferId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // Function to initiate a direct transfer
  Future<void> initiateDirectTransfer({
    required String name,
    required String email,
    required String phone,
    required String bankAccount,
    required String ifsc,
    required String amount,
  }) async {
    try {
      // Step 1: Get the Bearer token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');
      if (token == null) {
        print("No token found. Please authenticate first.");
        return;
      }

      // Step 2: Prepare the request body with dynamic inputs
      String transferId = generateTransferId(); // Random transfer ID generated here
      Map<String, dynamic> requestBody = {
        "beneDetails": {
          "beneId": "JOHN18012343", // Static for now, can be dynamic if needed
          "name": name,
          "email": email,
          "phone": phone,
          "bankAccount": bankAccount,
          "ifsc": ifsc,
          "address1": "ABC Street", // Static, can be dynamic if needed
          "city": "Bangalore", // Static, can be dynamic if needed
          "state": "Karnataka", // Static, can be dynamic if needed
          "pincode": "560001", // Static, can be dynamic if needed
        },
        "amount": amount,
        "transferId": transferId, // Using the generated transfer ID
        "transferMode": "neft", // Assuming NEFT transfer mode, can be changed if needed
      };

      // Step 3: Send the POST request to the API
      final response = await http.post(
        Uri.parse(directTransferUrl),
        headers: {
          'Authorization': 'Bearer $token', // Bearer token for authorization
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody), // JSON body with dynamic data
      );

      // Step 4: Handle the response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'SUCCESS') {
          print("Direct Transfer Request Success: ${responseData['message']}");
        } else {
          print("Error in Direct Transfer: ${responseData['message']}");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during direct transfer: $e");
    }
  }
}
