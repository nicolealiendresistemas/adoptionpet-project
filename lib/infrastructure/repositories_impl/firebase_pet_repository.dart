// infrastructure/repositories_impl/firebase_pet_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adopcionproyecto/domain/entities/pet.dart';
import 'package:adopcionproyecto/domain/repositories/pet_repository.dart';

class FirebasePetRepository implements PetRepository {
  final FirebaseFirestore firestore;

  FirebasePetRepository(this.firestore);

  @override
  Future<void> addPet(Pet pet) async {
    await firestore.collection('Pets').doc(pet.id).set(pet.toMap());
  }

  @override
  Future<void> updatePet(Pet pet) async {
    await firestore.collection('Pets').doc(pet.id).update(pet.toMap());
  }

  @override
  Future<void> deletePet(String id) async {
    await firestore.collection('Pets').doc(id).delete();
  }

  @override
  Stream<List<Pet>> getAvailablePets() {
    return firestore
        .collection('Pets')
        .where('AdoptionStatus', isEqualTo: 'Disponible')
        .snapshots()
        .map((snapshot) {
          // Ensure we convert each document into a Pet object
          return snapshot.docs.map((doc) => Pet.fromMap(doc.data(), doc.id)).toList();
        });
  }

  @override
  Stream<List<Pet>> getAllPets() {
    return firestore
        .collection('Pets')
        .snapshots()
        .map((snapshot) {
          // Ensure we convert each document into a Pet object
          return snapshot.docs.map((doc) => Pet.fromMap(doc.data(), doc.id)).toList();
        });
  }

  @override
  Future<void> updateAdoptionStatus(String petId, String status) async {
    await firestore.collection('Pets').doc(petId).update({
      'AdoptionStatus': status,
    });
  }
}
