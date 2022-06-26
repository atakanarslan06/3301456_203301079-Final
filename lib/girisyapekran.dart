import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemektarif/kayitekrani.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'girisyapildiekran.dart';
class GirisYap extends StatefulWidget {



  @override
  State<GirisYap> createState() => _GirisYapState();
}

class _GirisYapState extends State<GirisYap> {
  late String email, parola;
  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Giriş Yap Ekranı'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formAnahtari,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/hamburger.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (alinanMail) {
                      setState(() {
                        email = alinanMail;
                      });
                    },
                    validator: (alinanMail) {
                      return alinanMail!.contains('@')
                          ? null
                          : 'Geçersiz Mail';
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Adresinizi Giriniz',
                      hintText: 'Lütfen Geçerli Bir Email Adresi Giriniz:',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (alinanParola) {
                      setState(() {
                        parola = alinanParola;
                      });
                    },
                    validator: (alinanParola) {
                      return alinanParola!.length>=6
                          ? null
                          : 'Parolanız en az 6 karakter olmalıdır!';
                    },
                    obscureText: true,
                    decoration: InputDecoration(

                      labelText: 'Parolanızı Giriniz',
                      hintText: 'Lütfen Parolanızı Giriniz:',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 78,
                  child: ElevatedButton(
                    onPressed: (){
                      girisYap();
                    },
                    child: Text('GİRİŞ YAP'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade300,
                        textStyle: GoogleFonts.roboto(
                            fontSize: 24
                        )
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => KayitEkrani(),),);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Text('Kayıt Ol',
                      style: TextStyle(fontSize: 16,
                      color: Colors.amber),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void girisYap() {
    if (_formAnahtari.currentState!.validate()){
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: parola).then((user) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => GirisYapildi()), (Route<dynamic> route) => false);

      }).catchError((hata){
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
