// ignore: camel_case_types
class messege {
  String senderID;
  final String senderEmail;
  final String receiverID;
  final String text;
  final String timerStap;
  final String devicetoken;
  final String receiverDeviceToken;

  messege(this.senderID, this.senderEmail, this.receiverID, this.text,
      this.timerStap, this.devicetoken, this.receiverDeviceToken);

  Map<String, dynamic> toMap() {
    return {
      'SenderID': senderID,
      'SenderEmail': senderEmail,
      'ReceiverID': receiverID,
      'Messege': text,
      'timerStap': timerStap,
      'devicetoken': devicetoken,
      'receiverDeviceToken': receiverDeviceToken
    };
  }
}
