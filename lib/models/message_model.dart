class MessageModel {
  String? message;
  bool? sent;
  int? timestamp;
  int? type;

  MessageModel({this.message, this.sent, this.timestamp, this.type});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sent = json['sent'];
    timestamp = json['timestamp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['sent'] = this.sent;
    data['timestamp'] = this.timestamp;
    data['type'] = this.type;
    return data;
  }
}
