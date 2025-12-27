class UserProfileModel {
  final String name;
  final String uid;
  final String email;
  final String bio;
  final String link;
  final bool hasAvatar;

  UserProfileModel({
    required this.link,
    required this.email,
    required this.name,
    required this.uid,
    required this.bio,
    required this.hasAvatar,
  });

  UserProfileModel copyWith({
    String? name,
    String? uid,
    String? email,
    String? bio,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      link: link ?? this.link,
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
    : email = json["email"] ?? "",
      name = json["name"] ?? "",
      uid = json["uid"] ?? "",
      link = json["link"] ?? "",
      hasAvatar = json["hasAvatar"],
      bio = json["bio"] ?? "";

  UserProfileModel.empty()
    : email = '',
      name = '',
      uid = '',
      link = '',
      hasAvatar = false,
      bio = '';

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "uid": uid,
      "link": link,
      "bio": bio,
      "hasAvatar": hasAvatar,
    };
  }
}
