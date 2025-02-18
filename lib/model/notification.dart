class Notifications {
  String? id;
  Message? message;

  Notifications({this.id, this.message});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.message != null) {
      data['Message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? message;
  String? title;
  String? time;

  Message({this.message, this.title, this.time});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    title = json['title'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['title'] = this.title;
    data['time'] = this.time;
    return data;
  }
}