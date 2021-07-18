class Book {
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

  Book({this.sId, this.title, this.category, this.description, this.author, this.rating, this.price, this.posterImage, this.posterPublicId, this.postDate, this.iV});

  Book.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'title': title,
      'category': category,
      'description': description,
      'author': author,
      'rating': rating,
      'price': price,
      'posterImage': posterImage,
      'posterPublicId': posterPublicId,
      'postDate': postDate,
      'iV': iV,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      sId: map['sId'],
      title: map['title'],
      category: map['category'],
      description: map['description'],
      author: map['author'],
      rating: map['rating'],
      price: map['price'],
      posterImage: map['posterImage'],
      posterPublicId: map['posterPublicId'],
      postDate: map['postDate'],
      iV: map['iV'],
    );
  }
}
