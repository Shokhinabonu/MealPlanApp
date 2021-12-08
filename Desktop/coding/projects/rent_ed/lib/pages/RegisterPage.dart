import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_ed/widgets/TextFieldBox.dart';
import 'package:rent_ed/helpers/utils.dart';

class RegisterPage extends StatelessWidget {
  //const registerPage({ Key? key }) : super(key: key);
  List<String> registerHintTexts = Utils.getRegisterHintTexts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
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
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Register',
                      style: GoogleFonts.comfortaa(
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  TextFieldBox(registerHintTexts[
                      0]), //HOW TO CREATE A FOR LOOP OR SMTH???
                  TextFieldBox(registerHintTexts[1]),
                  TextFieldBox(registerHintTexts[2]),
                  TextFieldBox(registerHintTexts[3]),
                  TextFieldBox(registerHintTexts[4]),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/LogIn');
                            },
                            child: Text(
                              'BECOME \nA HOST ',
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                color: Colors.black,
                                // fontWeight: FontWeight.w900
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 20),
                              side: BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                       Container(width: 20,),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Register');
                            },
                            child: Text(
                              'BECOME \nA RENTER',
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,

                                color: Colors.white,
                                //fontWeight: FontWeight.w900
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 43, vertical: 20),
                              side: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.symmetric(vertical: 5),
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/Home');
                  //     },
                  //     child: Text(
                  //       'REGISTER',
                  //       style: GoogleFonts.comfortaa(
                  //         fontSize: 17,
                  //         color: Colors.white,
                  //         //fontWeight: FontWeight.w900
                  //       ),
                  //     ),
                  //     style: OutlinedButton.styleFrom(
                  //       backgroundColor: Colors.black,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(5))),
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 43, vertical: 20),
                  //       side: BorderSide(
                  //         color: Colors.black,
                  //         width: 3,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
