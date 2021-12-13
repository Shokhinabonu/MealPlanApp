import 'package:flutter/material.dart';
import './bensbuckslib.dart';

void main() => runApp(MealPlanApp());

class MealPlanApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      title: "Meal Plan App",
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: const Color(0xff183c6c)),
      home: DebugScreen(), //home: LoadingScreen(),
    );
  }
}

class DebugScreen extends StatelessWidget {
  void testCallback(BensBucks api, Map callbackData) {
    if (callbackData["type"] == BensBucksRequestType.login) {
      if (callbackData["error"] == BensBucksError.noError) {
        print("Login successful");
        api.getMainPage();
        //api.logout();
      } else if (callbackData["error"] == BensBucksError.connectionError) {
        print("Login failed: connection error");
      } else if (callbackData["error"] ==
          BensBucksError.invalidCredentialsError) {
        print("Login failed: credentials are invalid");
      } else if (callbackData["error"] ==
          BensBucksError.noStoredCredentialsError) {
        print(
            "Login failed: tried to login with no provided/saved credentials");
      }
    } else if (callbackData["type"] == BensBucksRequestType.logout) {
      if (callbackData["error"] == BensBucksError.noError) {
        print("Logout successful");
      } else if (callbackData["error"] == BensBucksError.notLoggedInError) {
        print("Logout failed: not logged in");
      }
    } else if (callbackData["type"] == BensBucksRequestType.getMainPage) {
      if (callbackData["error"] == BensBucksError.noError) {
        print("Main Page Loaded");
        print("User First Name: " + callbackData["firstName"]);
        print("User Last Name: " + callbackData["lastName"]);
        print("Flex Remaining: " + callbackData["flex"]);
        print("Swipes Remaining: " + callbackData["swipes"]);
        print("Recent Transactions:");

        for (var transaction in callbackData["recentTransactions"]) {
          print(transaction.location);
          print("     Date: " + transaction.date);
          print("     Time: " + transaction.time);
          print("     Type: " + transaction.flexOrSwipe);
          print("     Amount: " + transaction.amount);
        }
      } else if (callbackData["error"] == BensBucksError.notLoggedInError) {
        print("Main page load failed: not logged in");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    BensBucks api = BensBucks(testCallback);

    api.login(username: "usernamegoeshere", password: "passwordgoeshere");

    return Container();
  }
}
