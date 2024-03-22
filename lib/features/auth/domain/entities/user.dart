class User {
  final String id;
  final String email;
  final String fullName;
  final List<String> roles;
  final String token;

  User(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.roles,
      required this.token});

  //Creo un getter para determinar si tiene el rol de administrador
  bool get isAdmin {
    return roles.contains('admin');
  }
}
