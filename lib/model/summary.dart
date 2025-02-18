class SummaryGrade {
  final String fullName;
  final String hk1;
  final String hk2;
  final String semester;
  final double? toanHoc;
  final double? vatLi;
  final double? hoaHoc;
  final double? sinhHoc;
  final double? tinHoc;
  final double? nguVan;
  final double? lichSu;
  final double? diaLi;
  final double? tiengAnh;
  final double? gdcd;
  final double? congNghe;
  final String? theDuc;
  final double? gdqp;
  final double tbcmlhkl;

  SummaryGrade({
    required this.fullName,
    required this.hk1,
    required this.hk2,
    required this.semester,
    this.toanHoc,
    this.vatLi,
    this.hoaHoc,
    this.sinhHoc,
    this.tinHoc,
    this.nguVan,
    this.lichSu,
    this.diaLi,
    this.tiengAnh,
    this.gdcd,
    this.congNghe,
    this.theDuc,
    this.gdqp,
    required this.tbcmlhkl,
  });

  factory SummaryGrade.fromJson(Map<String, dynamic> json) {
    return SummaryGrade(
      fullName: json['full_name'],
      hk1: json['hk1'],
      hk2: json['hk2'],
      semester: json['semester'],
      toanHoc: (json['Toán học'] as num?)?.toDouble(),
      vatLi: (json['Vật lí'] as num?)?.toDouble(),
      hoaHoc: (json['Hóa học'] as num?)?.toDouble(),
      sinhHoc: (json['Sinh học'] as num?)?.toDouble(),
      tinHoc: (json['Tin học'] as num?)?.toDouble(),
      nguVan: (json['Ngữ văn'] as num?)?.toDouble(),
      lichSu: (json['Lịch sử'] as num?)?.toDouble(),
      diaLi: (json['Địa lí'] as num?)?.toDouble(),
      tiengAnh: (json['Tiếng anh'] as num?)?.toDouble(),
      gdcd: (json['GDCD'] as num?)?.toDouble(),
      congNghe: (json['Công nghệ'] as num?)?.toDouble(),
      theDuc: json['Thể dục'],
      gdqp: (json['GDQP'] as num?)?.toDouble(),
      tbcmlhkl: (json['TBcmlhkl'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'hk1': hk1,
      'hk2': hk2,
      'semester': semester,
      'Toán học': toanHoc,
      'Vật lí': vatLi,
      'Hóa học': hoaHoc,
      'Sinh học': sinhHoc,
      'Tin học': tinHoc,
      'Ngữ văn': nguVan,
      'Lịch sử': lichSu,
      'Địa lí': diaLi,
      'Tiếng anh': tiengAnh,
      'GDCD': gdcd,
      'Công nghệ': congNghe,
      'Thể dục': theDuc,
      'GDQP': gdqp,
      'TBcmlhkl': tbcmlhkl,
    };
  }
}
