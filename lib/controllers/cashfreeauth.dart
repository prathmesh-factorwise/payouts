import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String authCodeUrl = 'http://54.144.118.156/api/v1/staging/client/get-authorization-code';
  static const String tokenUrl = 'http://54.144.118.156/api/v1/staging/client/get-token';
  static const String clientId = 'HkqugqnMDDkflbAk';
  static const String clientSecret = '28bgsRRbFz6gRmsQQTAFrWBbx6GyissFWjHq';

  Future<void> getTokenAndSave() async {
    try {
      // Step 1: Get Auth Code
      final authCodeResponse = await http.post(
        Uri.parse(authCodeUrl),
        headers: {
          'Content-Type': 'application/json',
          'clientId': clientId,
          'clientSecret': clientSecret,
        },
      );

      if (authCodeResponse.statusCode == 200) {
        final authCodeData = json.decode(authCodeResponse.body);
        if (authCodeData is Map &&
            authCodeData.containsKey('status') &&
            authCodeData['status'] == 'SUCCESS' &&
            authCodeData.containsKey('data') &&
            authCodeData['data'] is Map &&
            authCodeData['data'].containsKey('authCode')) {
          String authCode = authCodeData['data']['authCode'];
          print("Auth Code: $authCode");

          // Step 2: Get Token using the Auth Code
          final tokenResponse = await http.post(
            Uri.parse(tokenUrl),
            headers: {
              'Authorization': 'Bearer $authCode',
              'Content-Type': 'application/json',
            },
          );

          if (tokenResponse.statusCode == 201) {
            final tokenData = json.decode(tokenResponse.body);
            if (tokenData is Map &&
                tokenData.containsKey('status') &&
                tokenData['status'] == 'SUCCESS' &&
                tokenData.containsKey('data') &&
                tokenData['data'] is Map &&
                tokenData['data'].containsKey('token')) {
              String token = tokenData['data']['token'];
              print("Token: $token");

              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('authToken', token);
              print("Token saved to SharedPreferences");
            } else {
              print("Unexpected token response format or status not SUCCESS:");
              print(tokenResponse.body);
            }
          } else {
            print("Error getting token: ${tokenResponse.statusCode}");
            print("Token response body: ${tokenResponse.body}"); // Print the body for debugging
          }
        } else {
          print("Unexpected auth code response format or status not SUCCESS:");
          print(authCodeResponse.body);
        }
      } else {
        print("Error getting auth code: ${authCodeResponse.statusCode}");
        print("Auth code response body: ${authCodeResponse.body}"); // Print the body for debugging
      }
    } catch (e) {
      print("Error during token retrieval: $e");
    }
  }


  Future<String?> getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
