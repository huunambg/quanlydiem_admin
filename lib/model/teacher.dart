class Teacher {
  int? userId;
  String? fullName;
  String? email;
  String? phoneNumber;

  Teacher({this.userId, this.fullName, this.email, this.phoneNumber});

  Teacher.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}