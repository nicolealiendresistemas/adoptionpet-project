import 'package:adopcionproyecto/domain/entities/pet.dart';
import 'package:adopcionproyecto/domain/repositories/pet_repository.dart';

class AddPet {
  final PetRepository repository;

  AddPet(this.repository);

  Future<void> call(Pet pet) {
    return repository.addPet(pet);
  }
}

class UpdatePet {
  final PetRepository repository;

  UpdatePet(this.repository);

  Future<void> call(Pet pet) {
    return repository.updatePet(pet);
  }
}

class DeletePet {
  final PetRepository repository;

  DeletePet(this.repository);

  Future<void> call(String id) {
    return repository.deletePet(id);
  }
}

class GetAvailablePets {
  final PetRepository repository;

  GetAvailablePets(this.repository);

  Stream<List<Pet>> call() {
    return repository.getAvailablePets();
  }
}

class GetAllPets {
  final PetRepository repository;

  GetAllPets(this.repository);

  Stream<List<Pet>> call() {
    return repository.getAllPets();
  }
}

class UpdateAdoptionStatus {
  final PetRepository repository;

  UpdateAdoptionStatus(this.repository);

  Future<void> call(String petId, String status) {
    return repository.updateAdoptionStatus(petId, status);
  }
}
