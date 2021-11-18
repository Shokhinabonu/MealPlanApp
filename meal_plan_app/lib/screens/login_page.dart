import 'package:flutter/material.dart';
import 'package:meal_plan_app/screens/plan_detail/plan_detail.dart';

class LoginPage extends StatelessWidget {
  // TODO: Implement
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
            child: ElevatedButton(
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PlanDetail()))
                    },
                child: Text("Login"))));
  }
}
