import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_co/model/auth_model.dart';

class AuthController {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<AuthResponse> signup(AuthModel model) async {
    return await supabase.auth.signUp(
      email: model.email,
      password: model.password,
      data: {"name": model.name},
    );
  }

  Future<AuthResponse> login(AuthModel model) async {
    return await supabase.auth.signInWithPassword(
      email: model.email,
      password: model.password,
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  User? get currentUser {
    return supabase.auth.currentUser;
  }

  String? get currentUserName {
    return supabase.auth.currentUser?.userMetadata?["name"];
  }

  bool get isLoggedIn {
    return supabase.auth.currentUser != null;
  }
}
