import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendNotificaiton(
    String title, String text, String receiverDeviceToken) async {
  var data = {
    'to': receiverDeviceToken,
    'notification': {
      'title': title,
      'body': text,
    }
  };
  final response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    body: jsonEncode(data),
    headers: {
      'content-type': 'application/json; charset=UTF-8',
      'Authorization':
          'key=AAAAhIgpBVE:APA91bFRlzL2nZk2C26Cwgiuxl_nchOfbHfYx48aaaqehJe5UrXs4V2U57PZYfuVV7m8yt9K_5R_eUZU1R9hlNAY288Wnt9I5e8eM0Uup1EzivRCU9vVDYBuDRPYEepEdQGn0jEP8pNg',
    },
  );

  if (response.statusCode == 200) {
  } else {}
}
