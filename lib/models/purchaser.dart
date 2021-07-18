class Purchaser {
  List<PurchasedBooks> purchasedBooks;
  String sId;
  String name;
  String phoneNumber;
  Address address;
  String purchasedDate;
  int iV;

  Purchaser({this.purchasedBooks, this.sId, this.name, this.phoneNumber, this.address, this.purchasedDate, this.iV});

  Purchaser.fromJson(Map<String, dynamic> json) {
    if (json['purchasedBooks'] != null) {
      // purchasedBooks = new List<PurchasedBooks>();
      purchasedBooks = [];
      json['purchasedBooks'].forEach((v) {
        purchasedBooks.add(new PurchasedBooks.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    purchasedDate = json['purchasedDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchasedBooks != null) {
      data['purchasedBooks'] = this.purchasedBooks.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['purchasedDate'] = this.purchasedDate;
    data['__v'] = this.iV;
    return data;
  }
}

class PurchasedBooks {
  String title;
  String category;
  String description;
  String price;

  PurchasedBooks({this.title, this.category, this.description, this.price});

  PurchasedBooks.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['category'] = this.category;
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}

class Address {
  String city;
  String country;

  Address({this.city, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }
}
