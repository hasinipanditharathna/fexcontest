class CatGiftsResponseModel {
  String? id;
  String? url;
  List<Categories>? categories = [];
  List<Breeds>? breeds;
  int? width;
  int? height;

  CatGiftsResponseModel(
      {this.id,
      this.url,
      this.categories,
      this.breeds,
      this.width,
      this.height});

  CatGiftsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    if (json.containsKey('categories')) {
      if (json['categories'] != null) {
        for (var item in json['categories']) {
          if (item['name'] != 'hats') {
            categories = <Categories>[];

            json['categories'].forEach((v) {
              categories!.add(Categories.fromJson(v));
            });
          }
        }
      }
    }

    if (json['breeds'] != null) {
      breeds = <Breeds>[];
      json['breeds'].forEach((v) {
        breeds!.add(Breeds.fromJson(v));
      });
    }
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['url'] = url;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (breeds != null) {
      data['breeds'] = breeds!.map((v) => v.toJson()).toList();
    }
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Categories {
  int? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}

class Breeds {
  String? id;
  String? name;

  Breeds({
    this.id,
    this.name,
  });

  Breeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = id;
    data['name'] = name;
    return data;
  }
}






// import 'dart:collection';

// class GifCat {
//   final String? id;
//   final String? url;
//   final int? width;
//   final int? height;
//   List<Catogories>? categories = [];
//   List<Breeds>? breeds = [];

//   GifCat({
//     required this.id,
//     required this.url,
//     required this.width,
//     required this.height,
//     required this.breeds,
//     required this.categories,
//   });

//   factory GifCat.fromJson(Map<String, dynamic> json) {
//     return GifCat(
//       id: json['id'] as String,
//       url: json['url'] as String,
//       width: json['width'] as int,
//       height: json['height'] as int,
//       categories: json['categories'] == null
//           ? null
//           : json['categories'] as List<Catogories>,
//       breeds: json['breeds'] == null ? null : json['breeds'] as List<Breeds>,
//     );
//   }
// }

// class Catogories {
//   final String id;
//   final String name;

//   Catogories(this.id, this.name);
// }

// class Breeds {
//   final String id;
//   final String name;

//   Breeds(this.id, this.name);
// }
