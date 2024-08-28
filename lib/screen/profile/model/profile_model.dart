class ProfileModel {
  String? name, mobile, email, bio;

  ProfileModel({this.name, this.mobile, this.email, this.bio});

  factory ProfileModel.mapToModel(Map m1) {
    return ProfileModel(
      mobile: m1['mobile'],
      bio: m1['bio'],
      email: m1['email'],
      name: m1['name'],
    );
  }
}
