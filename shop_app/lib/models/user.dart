class User {
  final int role;
  final String firstname;
  final String lastname;
  final String email;
  final String id;

  User({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.role,
    required this.id,
  });
}
