import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rent_car/Models/Agent.dart';
import 'package:rent_car/Pages/SignIn.dart';
import 'package:rent_car/Pages/WelcomePage.dart';
import 'package:rent_car/main.dart';

final storage = FlutterSecureStorage();

Future<String?> readToken() async {
  try {
    String? token = await storage.read(key: 'jwt_token');
    print('🔑 READ TOKEN: ${token != null ? 'Token exists' : 'Token is NULL'}');
    if (token != null) {
      print('   Token length: ${token.length} characters');
      print(
          '   Token preview: ${token.length > 20 ? token.substring(0, 20) + '...' : token}');
    }
    return token;
  } catch (e) {
    print('❌ Error reading JWT token: $e');
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

// 🔹 NEW: Unified Agent Profile Methods
Future<void> saveAgentProfile(Agent agent) async {
  try {
    final agentJson = json.encode(agent.toJson());
    await storage.write(key: 'agent_profile', value: agentJson);
  } catch (e) {
    print('Error saving agent profile: $e');
  }
}

Future<Agent?> readAgentProfile() async {
  try {
    final agentData = await storage.read(key: 'agent_profile');
    if (agentData != null) {
      final Map<String, dynamic> agentMap = json.decode(agentData);
      return Agent.fromJson(agentMap);
    }
    return null;
  } catch (e) {
    print('Error reading agent profile: $e');
    return null;
  }
}

Future<void> deleteAgentProfile() async {
  try {
    await storage.delete(key: 'agent_profile');
  } catch (e) {
    print('Error deleting agent profile: $e');
  }
}

Future<void> saveAgentName(String name) async {
  try {
    await storage.write(key: 'agent_name', value: name);
  } catch (e) {
    print('Error saving agent name: $e');
  }
}

Future<void> saveAgentEmail(String email) async {
  try {
    await storage.write(key: 'agent_email', value: email);
  } catch (e) {
    print('Error saving agent email: $e');
  }
}

Future<void> saveAgentPhone(String phone) async {
  try {
    await storage.write(key: 'agent_phone', value: phone);
  } catch (e) {
    print('Error saving agent phone: $e');
  }
}

Future<void> saveAgentAgency(String agency) async {
  try {
    await storage.write(key: 'agent_agency', value: agency);
  } catch (e) {
    print('Error saving agent agency: $e');
  }
}

Future<String?> readAgentName() async {
  try {
    return await storage.read(key: 'agent_name');
  } catch (e) {
    print('Error reading agent name: $e');
    return null;
  }
}

Future<String?> readAgentEmail() async {
  try {
    return await storage.read(key: 'agent_email');
  } catch (e) {
    print('Error reading agent email: $e');
    return null;
  }
}

Future<String?> readAgentPhone() async {
  try {
    return await storage.read(key: 'agent_phone');
  } catch (e) {
    print('Error reading agent phone: $e');
    return null;
  }
}

Future<String?> readAgentAgency() async {
  try {
    return await storage.read(key: 'agent_agency');
  } catch (e) {
    print('Error reading agent agency: $e');
    return null;
  }
}

Future<void> deleteAgentData() async {
  try {
    await storage.delete(key: 'agent_name');
    await storage.delete(key: 'agent_email');
    await storage.delete(key: 'agent_phone');
    await storage.delete(key: 'agent_agency');
    await storage.delete(key: 'agent_profile');
  } catch (e) {
    print('Error deleting agent data: $e');
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

    await deleteAgentProfile();
    print('✅ Agent profile supprimé');

    print('🔁 Navigation vers la première page');
    navigatorKey.currentState?.popUntil((route) => route.isFirst);

    print('➡️ Redirection vers SignInPage');
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );

    print('✅ Logout terminé avec succès');
  } catch (e) {
    print('❌ Erreur pendant le logout : $e');
  }
}

Future<String?> getToken() async {
  return await storage.read(key: 'jwt_token');
}

Future<void> saveUserName(String name) async {
  await storage.write(key: 'userName', value: name);
}
