import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'categorie_model.dart';
import 'categorie_screen.dart';
import 'data.dart';
import 'imageUI.dart';
import 'search_view.dart';

class MainUI extends StatefulWidget {
  const MainUI({Key? key}) : super(key: key);

  @override
  _MainUIState createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  List<CategorieModel> categories = [];

  List<PhotoList> _photos = [];
  int noOfImageToLoad = 30;

  Future<List<PhotoList>> fetchJson() async {
    String apiKey = '563492ad6f917000010000018dc55c90216c48058d27881b10950d9f';
    _photos = [];

    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1"),
        headers: {"Authorization": apiKey});

    List<PhotoList> pList = [];
    if (response.statusCode == 200) {
      var urJson = json.decode(response.body);
      urJson["photos"].forEach((element) async {
        pList.add(PhotoList.fromJson(element));
      });
    }
    return pList;
  }

  TextEditingController searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    categories = getCategories();
    //print(categories.length);

    fetchJson().then((value) {
      setState(() {
        _photos.addAll(value);
      });
    });
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 10;
        fetchJson().then((value) {
          setState(() {
            _photos.addAll(value);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                      controller: searchController,
                      decoration: const InputDecoration(
                          hintText: "search wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                          search: searchController.text,
                                        )));
                          }
                        },
                        child: Container(child: const Icon(Icons.search)))
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        categorieName: categories[index].categorieName,
                      );
                    }),
              ),
              GestureDetector(
                onPanEnd: (context) {
                  fetchJson().then((value) {
                    setState(() {
                      _photos.addAll(value);
                    });
                  });
                },
                child: GridView.count(
                    childAspectRatio: 0.6,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    crossAxisCount: 2,
                    children: List.generate(_photos.length, (index) {
                      return GridTile(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageUI(
                                      imageObject: _photos[index],
                                    )),
                          );
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                                imageUrl: _photos[index].src.portrait,
                                placeholder: (context, url) => Container(
                                      color: const Color(0xfff5f8fd),
                                    ),
                                fit: BoxFit.cover)),
                      ));
                    })),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.white, fontFamily: 'Overpass'),
      ),
      Text(
        "Store",
        style: TextStyle(color: Colors.deepOrange, fontFamily: 'Overpass'),
      )
    ],
  );
}

class CategoriesTile extends StatelessWidget {
  

  const CategoriesTile(
      {Key? key, required this.imgUrls, required this.categorieName})
      : super(key: key);
      final String imgUrls, categorieName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategorieScreen(
                      categorie: categorieName,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [

                ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:CachedNetworkImage(
                  imageUrl: imgUrls,
                  height: 80,
                  width: 120,
                  fit: BoxFit.cover,
                )),
            Container(
            
                width: 100,
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    categorieName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass'),
                  ),
                )),

              ],
            )
          ],
        ),
      ),
    );
  }
}
