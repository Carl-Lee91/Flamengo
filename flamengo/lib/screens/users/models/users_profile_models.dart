class UsersProfileModel {
  final String email;
  final String name;
  final String uid;
  final bool hasAvatar;

  UsersProfileModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.hasAvatar,
  });

  UsersProfileModel.empty()
      : email = "",
        uid = "",
        name = "",
        hasAvatar = false;

  UsersProfileModel.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        uid = json["uid"],
        name = json["name"],
        hasAvatar = json["hasAvatar"] ?? false;

  Map<String, String> toJson() {
    return {
      "email": email,
      "uid": uid,
      "name": name,
    };
  }

  UsersProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    bool? hasAvatar,
  }) {
    return UsersProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
