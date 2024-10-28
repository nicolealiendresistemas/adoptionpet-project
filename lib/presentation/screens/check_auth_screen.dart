// presentation/screens/check_auth_screen.dart

import 'package:flutter/material.dart';
import '../../infrastructure/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import '../../infrastructure/repositories_impl/firebase_pet_repository.dart';
import '../../application/use_cases/pet_use_cases.dart';

class CheckAuthScreen extends StatelessWidget {
  final AuthService authService;
  final FirebasePetRepository petRepository;

  const CheckAuthScreen({
    required this.authService,
    required this.petRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          // Usuario autenticado, redirigir a HomeScreen
          return HomeScreen(
            getAllPets: GetAllPets(petRepository),
            deletePet: DeletePet(petRepository),
            updatePet: UpdatePet(petRepository),
            addPet: AddPet(petRepository),
          );
        } else {
          // Usuario no autenticado, redirigir a LoginScreen
          return LoginScreen(authService: authService);
        }
      },
    );
  }
}
