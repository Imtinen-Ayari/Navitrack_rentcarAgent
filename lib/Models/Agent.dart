class Agent {
  final String name;
  final String email;
  final String phone;
  final String agency;

  Agent({
    required this.name,
    required this.email,
    required this.phone,
    required this.agency,
  });

  // Pour créer un Agent depuis un Map
  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      agency: json['agency'] ?? '',
    );
  }

  // Pour convertir un Agent en Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'agency': agency,
    };
  }

  // Pour créer une copie modifiée de l'agent
  Agent copyWith({
    String? name,
    String? email,
    String? phone,
    String? agency,
  }) {
    return Agent(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      agency: agency ?? this.agency,
    );
  }

  @override
  String toString() {
    return 'Agent(name: $name, email: $email, phone: $phone, agency: $agency)';
  }
}
