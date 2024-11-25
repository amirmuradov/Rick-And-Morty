import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final String created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
      created: json['created'],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        status,
        species,
        gender,
        image,
        created,
      ];

  @override
  String toString() {
    return 'Character{id: $id, name: $name, status: $status, species: $species, gender: $gender}';
  }
}
