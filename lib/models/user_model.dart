class User {
  final String? buildNumber;
  final String? userBio;
  final String? userEmail;
  final String? userId;
  final String? userImage;
  final bool? userIsAdmin;
  final String? userName;

  User({
    this.buildNumber,
    this.userBio,
    this.userEmail,
    this.userId,
    this.userImage,
    this.userIsAdmin,
    this.userName,
  });

  factory User.fromDocument(final documentSnapshot) {
    return User(
      buildNumber: documentSnapshot['build_number'],
      userBio: documentSnapshot['user_bio'],
      userEmail: documentSnapshot['user_email'],
      userId: documentSnapshot['user_id'],
      userImage: documentSnapshot['user_image'],
      userIsAdmin: documentSnapshot['user_is_admin'],
      userName: documentSnapshot['user_name'],
    );
  }
}
