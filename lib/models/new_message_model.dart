class NewMessageModel {
  final String receiverId;
  final String senderId;
  final String text;
  final String dateTime;

  NewMessageModel({
    required this.receiverId,
    required this.senderId,
    required this.text,
    required this.dateTime,
  });

  factory NewMessageModel.fromJson(Map<String, dynamic> json) {
    return NewMessageModel(
      receiverId: json['receiverId'],
      senderId: json['senderId'],
      text: json['text'],
      dateTime: json['dateTime'],
    );
  }

  Map<String ,dynamic> toMap(){
    return {
      'receiverId':receiverId,
      'senderId':senderId,
      'text':text,
      'dateTime':dateTime,
    };
  }
}
