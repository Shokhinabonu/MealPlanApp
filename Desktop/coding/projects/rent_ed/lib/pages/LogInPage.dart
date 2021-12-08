import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_ed/widgets/TextFieldBox.dart';
import 'package:rent_ed/helpers/utils.dart';

class LogInPage extends StatelessWidget {
  //const LogInPage({ Key? key }) : super(key: key);
  List<String> logInHintTexts = Utils.getLogInHintTexts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
               margin: EdgeInsets.only(top:20),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 28,
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'Log In',
                    style: GoogleFonts.comfortaa(
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                TextFieldBox(logInHintTexts[0]),
                TextFieldBox(logInHintTexts[0]),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Home');
                    },
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.comfortaa(
                        fontSize: 17,
                        color: Colors.white,
                        //fontWeight: FontWeight.w900
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 43, vertical: 20),
                      side: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
