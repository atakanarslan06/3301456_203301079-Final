import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'homepage.dart';

class GirisYapildi extends StatefulWidget {
  GirisYapildi({Key? key}) : super(key: key);

  @override
  State<GirisYapildi> createState() => _GirisYapildiState();
}

class _GirisYapildiState extends State<GirisYapildi>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    super.initState(); //Sayfa ilk buildinde hangi kodlar calısacak?

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animationController.forward();
    Future.delayed(Duration(seconds: 9)).then((value) => {
          //6sn sonra homepage'e gidecek.
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()))
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose(); //Splashi cope atar.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //sayfa iskeleti olusturma
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yemek Tarifleri',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/hamburger.png', //Splashteki hamburger
                    ),
                    fit: BoxFit.contain),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/yaprak.png',
                      ),
                      fit: BoxFit.contain)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 150,
                child: Lottie.asset('assets/splash_anim.json',
                    controller: _animationController, onLoaded: (composition) {
                  _animationController.duration = composition.duration;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
