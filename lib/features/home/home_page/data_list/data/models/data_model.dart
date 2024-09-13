import '../../domain/entities/data_entity.dart';

class DataModel extends DataEntity {
  DataModel({
    required super.name,
    required super.email,
    required super.body,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory DataModel.fromJson(Map<String, dynamic> map) {
    return DataModel(
      name: map['name'] as String,
      email: map['email'] as String,
      body: map['body'] as String,
    );
  }
}
