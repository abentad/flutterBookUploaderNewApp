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
  String sId;
  String title;
  String category;
  String description;
  String author;
  String rating;
  String price;
  String posterImage;
  String posterPublicId;
  String postDate;
  int iV;

  PurchasedBooks({this.sId, this.title, this.category, this.description, this.author, this.rating, this.price, this.posterImage, this.posterPublicId, this.postDate, this.iV});

  PurchasedBooks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    category = json['category'];
    description = json['description'];
    author = json['author'];
    rating = json['rating'];
    price = json['price'];
    posterImage = json['posterImage'];
    posterPublicId = json['posterPublicId'];
    postDate = json['postDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['category'] = this.category;
    data['description'] = this.description;
    data['author'] = this.author;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['posterImage'] = this.posterImage;
    data['posterPublicId'] = this.posterPublicId;
    data['postDate'] = this.postDate;
    data['__v'] = this.iV;
    return data;
  }
}

class Address {
  String city;
  String staddress;
  String region;
  String country;
  String poiAddrStreet;
  String poiName;

  Address({this.city, this.staddress, this.region, this.country, this.poiAddrStreet, this.poiName});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    staddress = json['staddress'];
    region = json['region'];
    country = json['country'];
    poiAddrStreet = json['poi_addr_street'];
    poiName = json['poi_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['staddress'] = this.staddress;
    data['region'] = this.region;
    data['country'] = this.country;
    data['poi_addr_street'] = this.poiAddrStreet;
    data['poi_name'] = this.poiName;
    return data;
  }
}
