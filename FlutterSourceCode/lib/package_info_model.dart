class Package {
  String title;
  int price;

  Package(this.title, this.price);

  Package.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['id'];
  }


}
