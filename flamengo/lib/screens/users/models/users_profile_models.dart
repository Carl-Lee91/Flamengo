class UserProfileModel {
  final String name;
  final String uid;

  UserProfileModel({
    required this.name,
    required this.uid,
  });

  UserProfileModel.empty()
      : uid = "",
        name = "";
}
