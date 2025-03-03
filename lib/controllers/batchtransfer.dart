import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BatchTransferController {
  // API URL for batch transfer
  static const String batchTransferUrl = 'http://54.144.118.156/api/v1/staging/payout/add-request-batch-transfer';

  // Function to send batch transfer request
  Future<void> initiateBatchTransfer(List<Map<String, dynamic>> batchData) async {
    try {
      // Step 1: Get the Bearer token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');
      if (token == null) {
        print("No token found. Please authenticate first.");
        return;
      }

      // Step 2: Prepare the request body for the batch transfer
      String batchTransferId = DateTime.now().millisecondsSinceEpoch.toString(); // Unique Batch ID based on timestamp
      Map<String, dynamic> requestBody = {
        "batchTransferId": batchTransferId,
        "batchFormat": "BANK_ACCOUNT",
        "batch": batchData, // The data passed from UI after parsing the Excel file
      };

      // Step 3: Send the POST request to the API
      final response = await http.post(
        Uri.parse(batchTransferUrl),
        headers: {
          'Authorization': 'Bearer $token', // Bearer token for authorization
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody), // JSON body with batch data
      );

      // Step 4: Handle the response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'SUCCESS') {
          print("Batch Transfer Request Success: ${responseData['message']}");
        } else {
          print("Error in Batch Transfer: ${responseData['message']}");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during batch transfer: $e");
    }
  }
}
