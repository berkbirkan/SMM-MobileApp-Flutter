class CategoriesModel {
  String name;
  String logo;
  String json;

  CategoriesModel({this.name, this.logo, this.json});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    json = json['json'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socialmedia_name'] = this.name;
    data['socialmedia_url'] = this.logo;
    data['socialmedia_id'] = this.json;
    return data;
  }
}