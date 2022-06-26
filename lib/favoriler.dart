
import 'package:flutter/material.dart';
import 'package:yemektarif/db/DatabaseHandler.dart';
import 'package:yemektarif/widgets/YemekWidgetState.dart';

import 'model/Favorilerim.dart';

class Favoriler extends StatefulWidget {
  const Favoriler({Key? key}) : super(key: key);

  @override
  State<Favoriler> createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  late DatabaseHandler handler;
  late Future<List<Favorilerim>> favorilerimList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DatabaseHandler(); // db nesnesi oluşturuyoruz
    handler.initializeDB(); // tablo oluşturuyoruz
    favorilerimList =
        handler.getFavorilerim(); // veritabanndan eleman cekiyoruz
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: FutureBuilder<List<Favorilerim>>(
              future: favorilerimList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          child: YemekWidgetState(
                              snapshot.data[index].yemekAdi,
                              snapshot.data[index].yemekURL,
                              "",
                              snapshot.data[index].tarifURL,
                              200,
                              150,
                              handler,
                              "delete.png",
                              30,
                              30,
                              snapshot.data[index].id),
                        );
                      });
                } else if (snapshot.hasError) {
                  return const Text("Error");
                }
                return const Text("Loading...");
              },
            ),
          ),
        ),
      ),
    );
  }
}
