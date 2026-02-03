import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../data/models/user_session_model.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Box<UserSessionModel> _sessionBox =
      Hive.box<UserSessionModel>('session');

  // Observable del usuario actual
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = _auth.currentUser;
  }

  // Registrar usuario
  Future<UserCredential?> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar sesión
      await _saveSession(credential.user!);

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Iniciar sesión
  Future<UserCredential?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar sesión
      await _saveSession(credential.user!);

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    await _auth.signOut();
    await _sessionBox.clear();
  }

  // Verificar si el usuario está autenticado
  bool isLoggedIn() {
    final hasSession = _sessionBox.isNotEmpty;
    final hasFirebaseUser = _auth.currentUser != null;
    return hasSession && hasFirebaseUser;
  }

  // Obtener usuario actual
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Obtener sesión guardada
  UserSessionModel? getSavedSession() {
    if (_sessionBox.isEmpty) return null;
    return _sessionBox.getAt(0);
  }

  // Guardar sesión en Hive
  Future<void> _saveSession(User user) async {
    final session = UserSessionModel(
      uid: user.uid,
      email: user.email ?? '',
      loginTime: DateTime.now(),
    );

    await _sessionBox.clear();
    await _sessionBox.add(session);
  }

  // Manejar excepciones de Firebase Auth
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'La contraseña es muy débil';
      case 'email-already-in-use':
        return 'El correo ya está registrado';
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'invalid-email':
        return 'Correo electrónico inválido';
      case 'user-disabled':
        return 'Usuario deshabilitado';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde';
      case 'operation-not-allowed':
        return 'Operación no permitida';
      default:
        return 'Error: ${e.message ?? 'Error desconocido'}';
    }
  }
}
