import 'package:adopcionproyecto/domain/entities/pet.dart';

abstract class PetRepository {
  Future<void> addPet(Pet pet); // Agrega una nueva mascota
  Future<void> updatePet(Pet pet); // Actualiza la información de la mascota
  Future<void> deletePet(String id); // Elimina una mascota
  Stream<List<Pet>> getAvailablePets(); // Obtiene mascotas disponibles para adopción
  Stream<List<Pet>> getAllPets(); // Obtiene todas las mascotas independientemente de su estado de adopción
  Future<void> updateAdoptionStatus(String petId, String status); // Actualiza el estado de adopción de una mascota
}
