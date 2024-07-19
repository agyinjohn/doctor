class DoctorModel {
  final String name;
  final String id;
  final String specialty;
  final String imageUrl;
  DoctorModel({
    required this.name,
    required this.id,
    required this.specialty,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'specialty': specialty,
      'imageUrl': imageUrl,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      name: map['name'] as String,
      id: map['id'] as String,
      specialty: map['specialty'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
