

import 'categorie_model.dart';

String apiKEY = "563492ad6f917000010000018dc55c90216c48058d27881b10950d9f";

  List<CategorieModel> categories = [];
List<CategorieModel> getCategories() {
  


  //
  String imgUrl1 =
  "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  String categorieName1 = "Street Art";
  CategorieModel categorieModel = CategorieModel(imgUrl: imgUrl1, categorieName: categorieName1);
  categories.add(categorieModel);


  //
  String imgUrl2 =
  "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  String categorieName2 = "Wild Life";
  categorieModel =CategorieModel(imgUrl: imgUrl2, categorieName: categorieName2);
  categories.add(categorieModel);


  //
  String imgUrl3 =
  "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  String categorieName3 = "Nature";
  categorieModel =CategorieModel(imgUrl: imgUrl3, categorieName: categorieName3);
  categories.add(categorieModel);

  //
  String imgUrl4 =
  "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  String categorieName4 = "City";
  categorieModel =CategorieModel(imgUrl: imgUrl4, categorieName: categorieName4);
  categories.add(categorieModel);
  //
  String imgUrl5 =
  "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  String categorieName5 = "Motivation";
  categorieModel =CategorieModel(imgUrl: imgUrl5, categorieName: categorieName5);
  categories.add(categorieModel);

  //
  String imgUrl6 =
  "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  String categorieName6 = "Bikes";
  categorieModel =CategorieModel(imgUrl: imgUrl6, categorieName: categorieName6);
  categories.add(categorieModel);
  //
  String imgUrl7 =
  "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  String categorieName7 = "Cars";
  categorieModel =CategorieModel(imgUrl: imgUrl7, categorieName: categorieName7);
  categories.add(categorieModel);

  return categories;
}
