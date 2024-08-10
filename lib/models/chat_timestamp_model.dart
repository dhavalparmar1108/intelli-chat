class ChatTimestampModel {
  String? timestamp;

  ChatTimestampModel({this.timestamp});

  ChatTimestampModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    return data;
  }
}
