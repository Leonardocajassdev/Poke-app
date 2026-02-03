import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/models/pokemon_model.dart';
import 'data/models/user_session_model.dart';
import 'services/auth_service.dart';
import 'presentation/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar adaptadores
  Hive.registerAdapter(PokemonModelAdapter());
  Hive.registerAdapter(UserSessionModelAdapter());

  // Abrir boxes
  await Hive.openBox<PokemonModel>('pokemon');
  await Hive.openBox<UserSessionModel>('session');

  // Inicializar servicios
  Get.put(AuthService());
  Get.put(AuthController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();

    return GetMaterialApp(
      title: 'Pokémon App - Bodytech',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: authService.isLoggedIn() ? AppRoutes.home : AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
