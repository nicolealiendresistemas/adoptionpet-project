// presentation/screens/add_new_pet_screen.dart

import 'package:adopcionproyecto/domain/entities/pet.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AddNewPetScreen extends StatefulWidget {
  final Pet? pet;
  final Function(Pet) addPet;

  const AddNewPetScreen({
    this.pet,
    required this.addPet,
    super.key,
  });

  @override
  _AddNewPetScreenState createState() => _AddNewPetScreenState();
}

class _AddNewPetScreenState extends State<AddNewPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final descriptionController = TextEditingController();
  String adoptionStatus = 'Disponible';

  @override
  void initState() {
    super.initState();
    if (widget.pet != null) {
      nameController.text = widget.pet!.name;
      breedController.text = widget.pet!.breed;
      ageController.text = widget.pet!.age.toString();
      descriptionController.text = widget.pet!.description;
      adoptionStatus = widget.pet!.adoptionStatus;
    }
  }

  void _savePet() {
    if (_formKey.currentState!.validate()) {
      final pet = Pet(
        id: widget.pet?.id ?? randomAlphaNumeric(8),
        name: nameController.text.trim(),
        breed: breedController.text.trim(),
        age: int.parse(ageController.text.trim()),
        description: descriptionController.text.trim(),
        adoptionStatus: adoptionStatus,
      );
      widget.addPet(pet);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900, // Fondo azul marino
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.pets, color: Colors.white), // Icono de mascota
            const SizedBox(width: 8),
            Text(
              widget.pet != null ? 'Editar Mascota' : 'Nueva Mascota',
              style: const TextStyle(
                color: Colors.white, // Texto blanco
                fontWeight: FontWeight.bold, // Texto en negritas
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.pet != null
                    ? 'Actualiza los datos de la mascota'
                    : 'Agrega una nueva mascota',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Campo para el nombre de la mascota
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la mascota',
                  labelStyle: const TextStyle(color: Colors.white70),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Campo para la raza de la mascota
              TextFormField(
                controller: breedController,
                decoration: InputDecoration(
                  labelText: 'Raza',
                  labelStyle: const TextStyle(color: Colors.white70),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La raza es obligatoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Campo para la edad de la mascota
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Edad (años)',
                  labelStyle: const TextStyle(color: Colors.white70),
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
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Introduce una edad válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Campo para la descripción de la mascota
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: const TextStyle(color: Colors.white70),
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
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La descripción es obligatoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Selector de estado de adopción
              DropdownButtonFormField<String>(
                value: adoptionStatus,
                decoration: InputDecoration(
                  labelText: 'Estado de Adopción',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownColor: Colors.blue.shade800,
                items: ['Disponible', 'En proceso', 'No Disponible']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status,
                              style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (newStatus) {
                  setState(() {
                    adoptionStatus = newStatus!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor selecciona un estado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // Botón de Guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _savePet,
                  icon: const Icon(Icons.save, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'Guardar Mascota',
                    style: TextStyle(fontSize: 18, color: Colors.blue.shade900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
