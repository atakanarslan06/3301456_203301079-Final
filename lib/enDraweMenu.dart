import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemektarif/girisyapekran.dart';

import 'homepage.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, //cihaza göre expand olması icin yazılır.
        child: Drawer(
          child: ListView(
            // padding: EdgeInsets.only(top: 20),
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topLeft,
                        image: AssetImage('assets/hamburger.png'),
                        fit: BoxFit.contain),
                  ),
                  child: IconButton(
                      alignment: Alignment.topRight,
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close_rounded)),
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade200,
                  border: Border(
                    top: BorderSide(
                        width: 0.8, color: Colors.black54),
                  ),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    //Liste olarak görünmesi icin navigasyonların, kullanılır.
                    title: Text(
                      'Ana Sayfa',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade200,
                  border: Border(
                    top: BorderSide(
                      width: 0.8,
                      color: Colors.black54,
                    ),
                  ),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title: Text(
                      'Çıkış Yap',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    onTap: (){
                      FirebaseAuth.instance.signOut().then((user) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => GirisYap()), (route) => false);
                        });
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height:150,
                    margin: EdgeInsets.only(top: 75,bottom: 35,right: 70,left: 70),
                    child: PieChart(
                        PieChartData(
                        centerSpaceRadius: 0,
                        borderData: FlBorderData(show: false),
                        sections: [
                          PieChartSectionData(
                              value: 40,
                              color: Colors.blue,
                              radius: 100),
                          PieChartSectionData(
                              value:60,
                              color: Colors.green,
                              radius: 110),
                          PieChartSectionData(
                              value:70,
                              color: Colors.red,
                              radius: 120)
                        ])),
                  ),
                  Container(
                    width: 60,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/hamburger.png'),
                            fit: BoxFit.contain)),
                  ),
                  Center(
                    child: Text(
                      'Afiyet Olsun',
                      style: GoogleFonts.inter(
                          textStyle:
                              TextStyle(color: Colors.green, fontSize: 20)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileElemanlari extends StatelessWidget {
  ListTileElemanlari({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Container(
        alignment: Alignment.centerLeft,
        child: ListTile(
          title: Text(
            'Ana Sayfa',
            style: GoogleFonts.inter(
                textStyle:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => homePageBody()));
          },
        ),
      ),
    );
  }
}
