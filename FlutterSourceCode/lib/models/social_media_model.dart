
class SocialMedaia {
  String name;

  SocialMedaia({this.name});

  SocialMedaia.fromJson(Map<String, dynamic> json) {
    name = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.name;
    return data;
  }
}