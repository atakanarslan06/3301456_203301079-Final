import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemektarif/model/Favorilerim.dart';
import 'package:yemektarif/yemektarifleriweb.dart';

import '../db/DatabaseHandler.dart';

class YemekWidgetState extends StatelessWidget {
  String yemekAd = "";
  String yemekImage = "";
  String yemekTarif = "";
  String yemekMalzeme = "";
  double width;
  double height;
  DatabaseHandler handler;
  String icon = "touch.png";
  int id;
  double widthIcon;
  double heightIcon;

  YemekWidgetState(
      this.yemekAd,
      this.yemekImage,
      this.yemekTarif,
      this.yemekMalzeme,
      this.width,
      this.height,
      this.handler,
      this.icon,
      this.widthIcon,
      this.heightIcon,this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Stack(alignment: Alignment.bottomRight, children: [
        Card(
          //Elevate edilmiş bir kart elementi.
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //aralarda bosluk bırakmak icin
            children: [
              Container(
                width: width,
                height: height,
                child: Image.network(
                  yemekImage,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  yemekAd,
                  style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                height: 30,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        //Yemek tarifi sayfasına gidiyor. Giderken aşağıdaki dataları cekiyor.
                        builder: (context) =>
                            YemekTarifleriWeb(yemekMalzeme, yemekAd)));
                  },
                  child: Text(
                    'Tarife Git >',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.w700)),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 233, 255, 234),
                      elevation: 0),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (icon == "touch.png") {
              handler.insertFavorilerim(Favorilerim(
                  id: Random().nextInt(90000000),
                  yemekAdi: yemekAd,
                  yemekURL: yemekImage,
                  tarifURL: yemekMalzeme));
              showCustomDialog(context, "Favorilerime Eklendi.");
            } else {
              handler.deleteFavorilerim(id);
              showCustomDialog(context, "Favorilerimden Silindi.");
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10, right: 10),
            child: Image.asset(
              "assets/$icon",
              width: widthIcon,
              height: heightIcon,
            ),
          ),
        )
      ]),
    );
  }

  void showCustomDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Container(
              width: double.infinity,
              height: 70,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/$icon",
                        width: 64,
                        height: 64,
                      ),
                      Text(
                        text,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  )),
            ),
          );
        });
      },
    );
  }
}
