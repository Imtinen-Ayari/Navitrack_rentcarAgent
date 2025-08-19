class Conducteur {
  String id;
  String id_user;
  String nom;
  String prenom;
  //DateTime dateNaissance;
  String lieuNaissance;
  String adresse;
  String nationalite;
  String pieceIdentite;
  //String dateDelivrancePI;
  //String dateDelivrancePermis;
  String numPermis;


  Conducteur({
    required this.id,
    required this.id_user,
    required this.nom,
    required this.prenom,
   // required this.dateNaissance,
    required this.lieuNaissance,
    required this.adresse,
    required this.nationalite,
    required this.pieceIdentite,
    //required this.dateDelivrancePI,
    //required this.dateDelivrancePermis,
    required this.numPermis,
  }); 

  factory Conducteur.fromJson(Map<String, dynamic> json) {
    return Conducteur(
      id: json['id'] as String? ?? 'defaultId',
      id_user: json['id_user'] as String? ?? 'defaultIdUser',
      nom: json['nom'] as String? ?? 'defaultNom',
      prenom: json['prenom'] as String? ?? 'defaultPrenom',
      //dateNaissance: json['dateNaissance'] as DateTime? ?? DateTime.now(),
      lieuNaissance: json['lieuNaissance'] as String? ?? 'defaultLieuNaissance',
      adresse: json['adresse'] as String? ?? 'defaultAdresse',
      nationalite: json['nationalite'] as String? ?? 'defaultNationalite',
      pieceIdentite: json['pieceIdentite'] as String? ?? 'defaultPieceIdentite',
      //dateDelivrancePI: json['dateDelivrancePI'] as String? ?? 'defaultDateDelivrancePI',
      //dateDelivrancePermis: json['dateDelivrancePermis'] as String? ?? 'defaultDateDelivrancePermis',
      numPermis: json['numPermis'] as String? ?? 'defaultNumPermis',
    );
  }
}