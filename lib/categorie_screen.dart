import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';
import 'imageUI.dart';
import 'mainUI.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({Key? key, required this.categorie}) : super(key: key);
  final String categorie;

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<PhotoList> _photos = [];

  Future<List<PhotoList>> fetchJson() async {
    String apiKey = '563492ad6f917000010000018dc55c90216c48058d27881b10950d9f';
    _photos = [];

    int noOfImageToLoad = 30;
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=$noOfImageToLoad&page=1"),
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

  @override
  void initState() {
    fetchJson().then((value) {
      setState(() {
        _photos.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
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
    );
  }
}
