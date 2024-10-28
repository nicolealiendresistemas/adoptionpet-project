// presentation/screens/home_screen.dart

import 'package:adopcionproyecto/application/use_cases/pet_use_cases.dart';
import 'package:adopcionproyecto/domain/entities/pet.dart';
import 'package:adopcionproyecto/presentation/screens/add_new_pet_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final GetAllPets getAllPets;
  final DeletePet deletePet;
  final UpdatePet updatePet;
  final AddPet addPet;

  const HomeScreen({
    required this.getAllPets,
    required this.deletePet,
    required this.updatePet,
    required this.addPet,
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<List<Pet>> petStream;
  List<Pet> allPets = []; // Lista completa de mascotas
  List<Pet> filteredPets = []; // Lista filtrada para mostrar en la pantalla
  final searchController = TextEditingController(); // Controlador para el campo de búsqueda

  @override
  void initState() {
    super.initState();
    petStream = widget.getAllPets();
    petStream.listen((petList) {
      setState(() {
        allPets = petList;
        filteredPets = allPets; // Inicialmente, mostrar todas las mascotas
      });
    });
  }

  // Colores de estado para cada mascota
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Disponible':
        return Colors.green;
      case 'En proceso':
        return Colors.yellow;
      case 'No Disponible':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Icono representativo del estado de adopción
  IconData _getStatusIcon(String status) {
    return Icons.pets;
  }

  // Función de búsqueda
  void _searchPet(String query) {
    final results = allPets.where((pet) {
      final nameLower = pet.name.toLowerCase();
      final breedLower = pet.breed.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) || breedLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredPets = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900, // Fondo azul marino
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Row(
          children: [
            Icon(Icons.pets, color: Colors.white), // Icono de pata
            SizedBox(width: 8),
            Text(
              'Adopción de Mascotas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: _searchPet,
              decoration: InputDecoration(
                hintText: 'Buscar mascota por nombre o raza',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              itemCount: filteredPets.length,
              itemBuilder: (context, index) {
                final pet = filteredPets[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(pet.adoptionStatus),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      _getStatusIcon(pet.adoptionStatus),
                      color: _getStatusColor(pet.adoptionStatus),
                      size: 36,
                    ),
                    title: Text(
                      '${pet.name} - ${pet.breed}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Descripción: ${pet.description}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        Text(
                          'Edad: ${pet.age} años',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        Text(
                          'Estado: ${pet.adoptionStatus}',
                          style: TextStyle(
                            color: _getStatusColor(pet.adoptionStatus),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        widget.deletePet(pet.id);
                      },
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AddNewPetScreen(pet: pet, addPet: widget.addPet.call),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddNewPetScreen(addPet: widget.addPet.call),
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
