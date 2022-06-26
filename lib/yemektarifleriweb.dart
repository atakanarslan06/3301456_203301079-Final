import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'enDraweMenu.dart';

class YemekTarifleriWeb extends StatefulWidget {
  String webUrl = "";
  String title = "";

  YemekTarifleriWeb(this.webUrl, this.title);

  @override
  State<YemekTarifleriWeb> createState() => _YemekTarifleriWebState();
}

class _YemekTarifleriWebState extends State<YemekTarifleriWeb> {
  @override
  Widget build(BuildContext context) {
    log("deneme : ${widget.webUrl}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image.asset('assets/hamburger.png',
                fit: BoxFit.contain,
                width: 65,
                height: 35,
                alignment: Alignment.topLeft),
            //title: Text(widget.title),
          ),
          endDrawer: const DrawerMenu(),
          body: WebView(
            initialUrl: widget.webUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ));
  }
}
