import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rent_car/Pages/SignIn.dart';
import 'package:rent_car/main.dart';

final storage = FlutterSecureStorage();

Future<String?> readToken() async {
  try {
    String? token = await storage.read(key: 'jwt_token');
    return token;
    ;
  } catch (e) {
    print('Error reading JWT token: $e');
    return null;
  }
}

Future<void> saveClientID(String clientID) async {
  try {
    await storage.write(key: 'client_id', value: clientID);
  } catch (e) {
    print('Error saving client ID: $e');
  }
}

Future<void> saveUserID(String userID) async {
  try {
    await storage.write(key: 'user_id', value: userID);
  } catch (e) {
    print('Error saving user ID: $e');
  }
}

Future<String?> readClientID() async {
  try {
    String? clientID = await storage.read(key: 'client_id');
    return clientID;
  } catch (e) {
    print('Error reading client ID: $e');
    return null;
  }
}

Future<String?> readUserID() async {
  try {
    String? userID = await storage.read(key: 'user_id');
    return userID;
  } catch (e) {
    print('Error reading user ID: $e');
    return null;
  }
}

Future<void> saveToken(String token) async {
  try {
    await storage.write(key: 'jwt_token', value: token);
  } catch (e) {
    print('Error saving JWT token: $e');
  }
}

Future<void> deleteToken() async {
  try {
    await storage.delete(key: 'jwt_token');
  } catch (e) {
    print('Error deleting JWT token: $e');
  }
}

Future<void> deleteClientID() async {
  try {
    await storage.delete(key: 'client_id');
  } catch (e) {
    print('Error deleting client ID: $e');
  }
}

Future<void> deleteUserID() async {
  try {
    await storage.delete(key: 'user_id');
  } catch (e) {
    print('Error deleting user ID: $e');
  }
}

void logout() async {
  print('🔴 Début du logout');
  try {
    await deleteToken();
    print('✅ Token supprimé');

    await deleteClientID();
    print('✅ Client ID supprimé');

    await deleteUserID();
    print('✅ User ID supprimé');

    print('🔁 Navigation vers la première page');
    navigatorKey.currentState?.popUntil((route) => route.isFirst);

    print('➡️ Redirection vers SignInPage');
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => SignInPage()),
    );

    print('✅ Logout terminé avec succès');
  } catch (e) {
    print('❌ Erreur pendant le logout : $e');
  }
}

Future<String?> getToken() async {
  return await storage.read(key: 'jwt_token');
}
