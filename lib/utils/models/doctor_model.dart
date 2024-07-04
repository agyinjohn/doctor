class DoctorModel {
  final String name;
  final String id;
  final String specialty;
  DoctorModel({
    required this.name,
    required this.id,
    required this.specialty,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'specialty': specialty,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      name: map['name'] as String,
      id: map['id'] as String,
      specialty: map['specialty'] as String,
    );
  }
}
