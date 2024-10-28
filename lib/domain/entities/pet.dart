// domain/entities/pet.dart
class Pet {
  final String id;
  final String name;
  final String breed;
  final int age;
  final String description;
  final String adoptionStatus;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.description,
    required this.adoptionStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Breed': breed,
      'Age': age,
      'Description': description,
      'AdoptionStatus': adoptionStatus,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map, String documentId) {
    return Pet(
      id: documentId,
      name: map['Name'] ?? '',
      breed: map['Breed'] ?? '',
      age: map['Age'] ?? 0,
      description: map['Description'] ?? '',
      adoptionStatus: map['AdoptionStatus'] ?? 'Disponible',
    );
  }
}
