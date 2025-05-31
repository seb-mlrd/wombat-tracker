class ProfilService {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String bio;
  final String password;
  final String avatar;
  final String roles;
  final int nbrStick;

  ProfilService({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.bio,
    required this.password,
    required this.avatar,
    required this.roles,
    required this.nbrStick,
  });
}
