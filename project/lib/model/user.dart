class UserModel {
  String id, username, mail, password, profPic, bio;
  UserModel({
    required this.id,
    required this.username,
    required this.mail,
    required this.password,
    required this.profPic,
    required this.bio,
    this.booked,
    this.favorite,
  });

  List<String>? booked, favorite;

  static UserModel? current;

  factory UserModel.fromJson(Map j) => UserModel(
        id: j["id"],
        username: j["username"],
        mail: j["mail"],
        password: j["password"],
        profPic: j["profPic"],
        bio: j["bio"],
        booked: j["booked"].map<String>((i) => i as String).toList(),
        favorite: j["favorite"].map<String>((i) => i as String).toList(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "mail": mail,
        "password": password,
        "profPic": profPic,
        "bio": bio,
        "booked": booked,
        "favorite": favorite,
      };
}
