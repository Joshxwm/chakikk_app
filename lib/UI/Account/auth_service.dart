import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Iniciar sesión
  Future<String?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Inicio de sesión exitoso: ${userCredential.user?.email}";
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    }
  }

  // Registrar usuario
  Future<String?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Registro exitoso: ${userCredential.user?.email}";
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Obtener usuario actual
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Manejo de errores de autenticación
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "No se encontró un usuario con ese correo.";
      case 'wrong-password':
        return "Contraseña incorrecta.";
      case 'email-already-in-use':
        return "El correo ya está en uso.";
      case 'weak-password':
        return "La contraseña es demasiado débil.";
      case 'invalid-email':
        return "El correo no es válido.";
      default:
        return "Error: ${e.message}";
    }
  }
}
