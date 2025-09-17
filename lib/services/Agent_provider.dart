import 'package:flutter/foundation.dart';
import 'package:rent_car/Models/Agent.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class AgentProvider extends ChangeNotifier {
  Agent? _currentAgent;

  Agent? get currentAgent => _currentAgent;

  AgentProvider() {
    _loadAgentProfile();
  }

  Future<void> _loadAgentProfile() async {
    try {
      final agent = await readAgentProfile();

      if (agent != null) {
        _currentAgent = agent;
      } else {
        _currentAgent = Agent(
          name: 'Agent Name',
          email: 'name@gmail.com',
          phone: '+216 25 485 865',
          agency: 'RentCar',
        );

        await saveAgentProfile(_currentAgent!);
      }
      notifyListeners();
    } catch (e) {
      print('Erreur lors du chargement du profil agent: $e');

      _currentAgent = Agent(
        name: 'Agent Name',
        email: 'name@gmail.com',
        phone: '+216 25 485 865',
        agency: 'RentCar',
      );
      notifyListeners();
    }
  }

  Future<bool> updateAgentProfile(Agent updatedAgent) async {
    try {
      _currentAgent = updatedAgent;
      await saveAgentProfile(_currentAgent!);
      notifyListeners();
      return true;
    } catch (e) {
      print('Erreur lors de la mise à jour du profil: $e');
      return false;
    }
  }

  Future<void> resetProfile() async {
    try {
      await deleteAgentProfile();
      _currentAgent = Agent(
        name: 'Agent Name',
        email: 'name@gmail.com',
        phone: '+216 25 485 865',
        agency: 'RentCar',
      );
      await saveAgentProfile(_currentAgent!);
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la réinitialisation du profil: $e');
    }
  }

  Future<void> reloadProfile() async {
    await _loadAgentProfile();
  }
}
