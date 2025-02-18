class Class {
  int? classId;
  String? className;
  String? academicYear;
  int? teacherId;
  int? status; // 0 for inactive, 1 for active

  Class({
    this.classId,
    this.className,
    this.academicYear,
    this.teacherId,
    this.status,
  });

  Class.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    className = json['class_name'];
    academicYear = json['academic_year'];
    teacherId = json['teacher_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId.toString();
    data['class_name'] = this.className;
    data['academic_year'] = this.academicYear;
    data['teacher_id'] = this.teacherId.toString();
    data['status'] = this.status.toString();
    return data;
  }
}
