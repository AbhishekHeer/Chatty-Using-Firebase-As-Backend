// ignore: camel_case_types
class messege {
  String senderID;
  final String senderEmail;
  final String receiverID;
  final String text;
  final String timerStap;

  messege(this.senderID, this.senderEmail, this.receiverID, this.text,
      this.timerStap);

  Map<String, dynamic> toMap() {
    return {
      'SenderID': senderID,
      'SenderEmail': senderEmail,
      'ReceiverID': receiverID,
      'Messege': text,
      'timerStap': timerStap,
    };
  }
}
