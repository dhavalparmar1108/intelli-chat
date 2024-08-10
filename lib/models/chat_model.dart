class ChatModel {
  String? name;
  String? dp;
  String? message;
  String? userId;
  int? messageType;

  ChatModel({this.name, this.dp, this.message, this.userId, this.messageType});

  ChatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dp = json['dp'];
    message = json['message'];
    userId = json['userId'];
    messageType = json['message_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dp'] = this.dp;
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['message_type'] = this.messageType;
    return data;
  }
}
