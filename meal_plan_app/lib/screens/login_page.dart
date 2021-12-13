import 'package:flutter/material.dart';
import 'package:meal_plan_app/parser/bensbuckslib.dart';
import 'package:meal_plan_app/screens/plan_detail/plan_detail.dart';
import 'package:meal_plan_app/parser/bensbuckslib.dart';

class LoginPage extends StatefulWidget {
  // TODO: Implement
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userName;
  var password;
  var rememberMeValue = false;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  var myContext = null;
  void testCallback(BensBucks api, Map callbackData) {
    if (callbackData["type"] == BensBucksRequestType.login) {
      if (callbackData["error"] == BensBucksError.noError) {
        print("Login successful");
        Navigator.push<void>(
          myContext,
          MaterialPageRoute<void>(
            builder: (BuildContext myContext) => PlanDetail(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                      ),
                      hintText: "Enter You Email",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                      ),
                      hintText: "Enter You Password",
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      //api.login and if else statement and receive the context
                      BensBucks api = BensBucks(testCallback);
                      api.login(
                          username: userNameController.text.toString(),
                          password: passwordController.text.toString());
                    },
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'Remember Me',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Checkbox(
                          value: rememberMeValue,
                          onChanged: (val) {
                            setState(() {
                              rememberMeValue = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
