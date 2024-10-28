import 'package:adopcionproyecto/application/use_cases/pet_use_cases.dart';
import 'package:adopcionproyecto/infrastructure/repositories_impl/firebase_pet_repository.dart';
import 'package:adopcionproyecto/infrastructure/auth_service.dart'; // Importa el servicio de autenticación
import 'package:adopcionproyecto/presentation/screens/check_auth_screen.dart';
import 'package:adopcionproyecto/presentation/screens/home_screen.dart';
import 'package:adopcionproyecto/presentation/screens/login_screen.dart'; // Importa la pantalla de login
import 'package:adopcionproyecto/presentation/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBq9mxbg46jOw97ufnaX5kmtC1hYVTUVpk",
        authDomain: "localhost",
        projectId: "docencia-2024",
        storageBucket: "docencia-2024.appspot.com",
        messagingSenderId: "TU_MESSAGING_SENDER_ID",
        appId: "TU_APP_ID",
        measurementId: "TU_MEASUREMENT_ID",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  final authService = AuthService();
  await authService.signOut(); // Cierra sesión cada vez que la app inicia
  final petRepository = FirebasePetRepository(FirebaseFirestore.instance);

  runApp(MyApp(authService: authService, petRepository: petRepository));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final FirebasePetRepository petRepository;

  const MyApp(
      {required this.authService, required this.petRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/check-auth': (context) => CheckAuthScreen(
              authService: authService,
              petRepository: petRepository,
            ),
        '/home': (context) => HomeScreen(
              getAllPets: GetAllPets(petRepository),
              deletePet: DeletePet(petRepository),
              updatePet: UpdatePet(petRepository),
              addPet: AddPet(petRepository),
            ),
        '/login': (context) => LoginScreen(authService: authService),
      },
    );
  }
}
