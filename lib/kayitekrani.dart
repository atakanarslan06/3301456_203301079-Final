import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'girisyapekran.dart';
import 'girisyapildiekran.dart';

class KayitEkrani extends StatefulWidget {
  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  late String email, parola;
  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Kayıt Ekranı'),
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
                        email = alinanMail; //alınan mail email değişkenine yönledirdik
                      });
                    },
                    validator: (alinanMail) {
                      return alinanMail!.contains('@') //alınan mail @ işareti içeriyor mu içermiyorsa ... if else yapısı
                          ? null
                          : 'Mail adresiniz geçersiz! Lütfen geçerli bir mail adresi giriniz!';
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Adresinizi Giriniz',
                      hintText: 'Lütfen Geçerli Bir Email Adresi Giriniz:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                      return alinanParola!.length >= 6
                          ? null
                          : 'Parolanız en az 6 karakter olmalıdır!';
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Parolanızı Giriniz',
                      hintText: 'Lütfen Parolanızı Giriniz:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 78,
                  child: ElevatedButton(
                    onPressed: () {
                      kayitEkle();
                    },
                    child: Text('KAYIT OL'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade300,
                        textStyle: GoogleFonts.roboto(fontSize: 24)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GirisYap(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Mevcut bir hesabım bulunmakta',
                      style: TextStyle(fontSize: 16, color: Colors.amber),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Formun içerisinde _formanahtari ile taşıdığımız bilgileri firebaseye yönlendirecek
  void kayitEkle() {
    if (_formAnahtari.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: parola)
          .then((user) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => GirisYapildi()),
            (Route<dynamic> route) => false);
      }).catchError((hata) {
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
