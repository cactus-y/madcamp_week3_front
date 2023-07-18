import 'package:flutter/material.dart';
import './SignupPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  TextEditingController _id = TextEditingController();
  TextEditingController _pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "몰입캠프",
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFCD85F7, {
          50: Color(0xFFF7E7FD),
          100: Color(0xFFE2C0F5),
          200: Color(0xFFC08AEB),
          300: Color(0xFF9D5EE1),
          400: Color(0xFF8140D9),
          500: Color(0xFFCD85F7),
          600: Color(0xFF7431CF),
          700: Color(0xFF5A23B6),
          800: Color(0xFF441DA1),
          900: Color(0xFF2D1181),
        }),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("몰입캠프"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: 150,
                  child: Image(
                    image: AssetImage('assets/icon.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("아직 회원이 아니신가요?"),
                      TextButton(
                        onPressed: () {},
                        child: Text("회원가입 하러가기"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    controller: _id,
                    decoration: InputDecoration(
                      labelText: '아이디',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    controller: _pwd,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      String enteredText = _id.text + _pwd.text;
                      print('Entered Text: $enteredText');
                      Navigator.push(context,MaterialPageRoute(builder: (context) => MapPage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text("로그인"),
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
}