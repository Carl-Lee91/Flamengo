class UsersProfileModel {
  final String email;
  final String name;
  final String uid;

  UsersProfileModel({
    required this.email,
    required this.name,
    required this.uid,
  });

  UsersProfileModel.empty()
      : email = "",
        uid = "",
        name = "";

  UsersProfileModel.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        uid = json["uid"],
        name = json["name"];

  Map<String, String> toJson() {
    return {
      "email": email,
      "uid": uid,
      "name": name,
    };
  }
}
