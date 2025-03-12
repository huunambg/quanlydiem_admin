class TeacherAdmin {
  int? userId;
  String? password;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? role;

  TeacherAdmin({
    this.userId,
    this.password,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.role,
  });

  TeacherAdmin.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    password = json['password'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    role = json['role'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['user_id'] = userId.toString();
    data['password'] = password.toString();
    data['full_name'] = fullName.toString();
    data['email'] = email.toString();
    data['phone_number'] = phoneNumber.toString();
    data['role'] = role.toString();
    data['status'] = "1";
    return data;
  }

  TeacherAdmin copyWith({
    int? userId,
    String? password,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? role,
    String? createdAt,
  }) {
    return TeacherAdmin(
      userId: userId ?? this.userId,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }
}
