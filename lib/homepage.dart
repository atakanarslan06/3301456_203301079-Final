import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemektarif/alinacaklist.dart';
import 'package:yemektarif/favoriler.dart';
import 'package:yemektarif/model/yemek.dart';
import 'package:yemektarif/widgets/YemekWidgetState.dart';
import 'db/DatabaseHandler.dart';
import 'enDraweMenu.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    homePageBody(),
    AlinacakList(),
    Favoriler(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //iskelet olusur
      appBar: AppBar(
        //üst bar
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Image.asset('assets/hamburger.png',
            fit: BoxFit.contain,
            width: 65,
            height: 35,
            alignment: Alignment.topLeft),
      ),
      endDrawer: DrawerMenu(), //icon olusumu bu textten geliyor
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.white),
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.lightGreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.brown,
            ),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.blueAccent,
            ),
            label: 'Alınacaklar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            label: 'Favoriler',
          ),
        ],
      ),
    );
  }
}

class homePageBody extends StatefulWidget {
  @override
  State<homePageBody> createState() => _homePageBodyState();
}

class _homePageBodyState extends State<homePageBody> {
  late DatabaseHandler handler;

  Yemek yemekList = Yemek("title", "category", "url", "image");

  Uri url = Uri.parse(
      "https://cooking-recipe2.p.rapidapi.com/getbycat/Indian%20Desserts");
  late Future yemekListesi;

  Future yemekleriGetir() async {
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json; charset=UTF-8',
        "content-type": "application/json",
        'X-RapidAPI-Key': '32d70a1060msh2ed77b94f58b001p1978a6jsn332b7d959551',
        'X-RapidAPI-Host': 'cooking-recipe2.p.rapidapi.com'
      },
    );
    var responseBody = json.decode(response.body);
    List<Yemek> list = [];
    for (var obj in responseBody) {
      list.add(Yemek(obj["title"], obj["category"], obj["url"], obj["img"]));
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yemekListesi = yemekleriGetir();
    handler = DatabaseHandler();
    handler.initializeDB();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //Hoşgeldin yazısının arkasındaki yeşil kutu
            width: 600,
            height: 250,
            color: Color.fromARGB(255, 233, 255, 234),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              //her yerden 16 padding verir.
              child: Column(
                //Textlerin yazılması için column oluşturuldu.
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                //container solundan başlaması ve textlerin ortalanması işine yarar.
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Hoşgeldin!',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      'Şöyle lezzetli bir vejeteryan yemek tarifi mi arıyorsun? Aşağıya doğru kaydırarak istediğini bulabilirsin!',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 105, 105, 105),
                              fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            alignment: Alignment.topLeft,
            child: Text(
              'Senin için listeledik',
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: yemekListesi,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return YemekWidgetState(
                          snapshot.data[i].title,
                          snapshot.data[i].image,
                          snapshot.data[i].category,
                          snapshot.data[i].url,
                          300,
                          300,
                          handler,
                          "touch.png",
                          44,
                          44,
                          0);
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text("Error");
                }
                return const Text("Loading...");
              },
            ),
          ),
        ],
      ),
    );
  }
}

// TextStyle(

//                           fontSize: 20,
//                           color: Color.fromARGB(255, 105, 105, 105)),
