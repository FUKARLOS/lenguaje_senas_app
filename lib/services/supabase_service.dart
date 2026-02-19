import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/nivel_model.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  // Auth methods
  Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp(
    String email,
    String password,
    String username,
  ) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
  }

  Future<void> signOut() async {
    return await client.auth.signOut();
  }

  // Data methods
  Future<List<Nivel>> getNiveles() async {
    try {
      final response = await client
          .from('niveles')
          .select()
          .order('id', ascending: true);

      final data = response as List<dynamic>;
      return data.map((e) => Nivel.fromMap(e)).toList();
    } catch (e) {
      // Handle error gracefully or rethrow
      debugPrint('Error fetching niveles: $e');
      return [];
    }
  }
}
