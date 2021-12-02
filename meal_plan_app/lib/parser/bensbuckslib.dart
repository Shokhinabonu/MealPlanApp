import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
TODO:
- Get main page info
  - Name
*/

enum BensBucksRequestType { login, logout, storedCredentialsCheck, getMainPage }

enum BensBucksError {
  noError,
  connectionError,
  invalidCredentialsError,
  noStoredCredentialsError,
  notLoggedInError
}

class BensBucksTransaction {
  String date;
  String time;
  String location;
  String flexOrSwipe;
  String amount;

  BensBucksTransaction(
      this.date, this.time, this.location, this.flexOrSwipe, this.amount);
}

class BensBucks {
  final secureStorage = const FlutterSecureStorage();

  bool loggedIn = false;

  Function(BensBucks, Map) responseCallback;

  String loginVar_DVH = "";
  String loginVar_BNES_DVH = "";
  String loginVar_ncforminfo = "";

  String loginVar_JSESSIONID = "";
  String loginVar_BNES_JSESSIONID = "";

  BensBucks(this.responseCallback);

  Map createErrorResponseMap(
      BensBucksRequestType requestType, BensBucksError requestError) {
    Map mapToReturn = {};

    mapToReturn["type"] = requestType;
    mapToReturn["error"] = requestError;

    return mapToReturn;
  }

  bool currentlyLoggedIn() {
    return loggedIn;
  }

  void checkIfCredentialsStored() async {
    var username = await secureStorage.read(key: "username");

    Map returnMap = createErrorResponseMap(
        BensBucksRequestType.storedCredentialsCheck, BensBucksError.noError);

    returnMap["credentialsAreStored"] = username != null;

    responseCallback.call(this, returnMap);
  }

  void logout() async {
    if (loggedIn) {
      loginVar_DVH = "";
      loginVar_BNES_DVH = "";
      loginVar_ncforminfo = "";
      loginVar_JSESSIONID = "";
      loginVar_BNES_JSESSIONID = "";

      await secureStorage.delete(key: "username");
      await secureStorage.delete(key: "password");

      loggedIn = false;

      responseCallback.call(
          this,
          createErrorResponseMap(
              BensBucksRequestType.logout, BensBucksError.noError));
    } else {
      responseCallback.call(
          this,
          createErrorResponseMap(
              BensBucksRequestType.logout, BensBucksError.notLoggedInError));
    }
  }

  void getMainPage() async {
    if (loggedIn) {
      try {
        final mainPageRequest = await http.get(
            Uri.parse('https://fandm.campuscardcenter.com/ch/'),
            headers: <String, String>{
              'Accept':
                  'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
              'Cookie': 'JSESSIONID=' +
                  loginVar_JSESSIONID +
                  '; BNES_JSESSIONID=' +
                  loginVar_BNES_JSESSIONID +
                  '; DVH=' +
                  loginVar_DVH +
                  '; __utmz=230975552.1635463023.8.7.utmcsr=fandmbensbucks.com|utmccn=(referral)|utmcmd=referral|utmcct=/; __utma=230975552.786452026.1630454332.1635463023.1636236621.9; __utmc=230975552; __utmt=1; __utmb=230975552.2.10.1636236621; BNES_DVH=' +
                  loginVar_BNES_DVH,
            }).timeout(const Duration(seconds: 7));

        var mainPage = mainPageRequest.body;

        String firstName = "";
        String lastName = "";

        mainPage = mainPage
            .substring(mainPage.indexOf('<td nowrap colspan="2">') + 23);

        var wholeName = mainPage.substring(0, mainPage.indexOf("</td>"));

        if (wholeName.contains(" ")) {
          firstName = wholeName.substring(0, wholeName.indexOf(" "));
          lastName = wholeName
              .substring(wholeName.indexOf(" ") + 1)
              .replaceAll(" ", "")
              .replaceAll("\n", "");
        } else {
          firstName = wholeName.replaceAll(" ", "").replaceAll("\n", "");
        }

        String flexValue = "";
        String swipesValue = "";

        while (mainPage.contains("> View Transactions </a>")) {
          mainPage = mainPage
              .substring(mainPage.indexOf("> View Transactions </a>") + 24);

          var currentEntryIdentifier =
              mainPage.substring(mainPage.indexOf("<td nowrap>") + 11);

          currentEntryIdentifier = currentEntryIdentifier.substring(
              0, currentEntryIdentifier.indexOf("</td>"));

          var currentEntryValue = mainPage.substring(
              mainPage.indexOf('<td nowrap><div align="right">') + 30);

          currentEntryValue = currentEntryValue.substring(
              0, currentEntryValue.indexOf("</div>")); //</td>

          if (currentEntryIdentifier.contains("Flex")) {
            flexValue = currentEntryValue.replaceAll(" ", "");
          } else if (currentEntryIdentifier.contains("Meals")) {
            swipesValue = currentEntryValue.replaceAll(" ", "");
          }
        }

        var recentTransactions = [];

        while (mainPage.contains('<tr id="EntryRow" >')) {
          mainPage =
              mainPage.substring(mainPage.indexOf('<tr id="EntryRow" >') + 19);

          var currentEntry = mainPage.substring(0, mainPage.indexOf('</tr>'));

          var date = "";
          var time = "";
          var location = "";
          var flexOrSwipe = "";
          var amount = "";

          var tdIDX = 0;

          while (currentEntry.contains("<td nowrap>")) {
            currentEntry = currentEntry
                .substring(currentEntry.indexOf("<td nowrap>") + 11);

            var currentContent =
                currentEntry.substring(0, currentEntry.indexOf("</td>"));

            if (tdIDX == 0) {
              date = currentContent;
            } else if (tdIDX == 1) {
              time = currentContent;
            } else if (tdIDX == 2) {
              location = currentContent.replaceAll(" AUTH", "");
            } else if (tdIDX == 3) {
              if (currentContent.contains("Flex")) {
                flexOrSwipe = "flex";
              } else {
                flexOrSwipe = "swipe";
              }
            }

            tdIDX++;
          }

          amount = currentEntry
              .substring(currentEntry.indexOf('<div align="right">') + 19,
                  currentEntry.indexOf('</div>'))
              .replaceAll(" ", "");

          recentTransactions.add(
              BensBucksTransaction(date, time, location, flexOrSwipe, amount));
        }

        Map mapToReturn = createErrorResponseMap(
            BensBucksRequestType.getMainPage, BensBucksError.noError);

        mapToReturn["firstName"] = firstName;
        mapToReturn["lastName"] = lastName;
        mapToReturn["flex"] = flexValue;
        mapToReturn["swipes"] = swipesValue;
        mapToReturn["recentTransactions"] = recentTransactions;

        responseCallback.call(this, mapToReturn);
      } on SocketException {
        responseCallback.call(
            this,
            createErrorResponseMap(BensBucksRequestType.getMainPage,
                BensBucksError.connectionError));
      } on TimeoutException {
        responseCallback.call(
            this,
            createErrorResponseMap(BensBucksRequestType.getMainPage,
                BensBucksError.connectionError));
      } on Error {
        responseCallback.call(
            this,
            createErrorResponseMap(BensBucksRequestType.getMainPage,
                BensBucksError.connectionError));
      }
    } else {
      responseCallback.call(
          this,
          createErrorResponseMap(BensBucksRequestType.getMainPage,
              BensBucksError.notLoggedInError));
    }
  }

  void login({username, password}) async {
    //Load login page
    try {
      final loginPage = await http
          .get(Uri.parse('https://fandm.campuscardcenter.com/ch/login.html'))
          .timeout(const Duration(seconds: 5));

      if (loginPage.statusCode == 200) {
        String rawLoginPage = loginPage.body;
        var rawCookies = loginPage.headers["set-cookie"];

        if (rawCookies != null) {
          var cookies = rawCookies.split(",");

          for (var cookie in cookies) {
            if (cookie.contains("BNES_DVH=")) {
              loginVar_BNES_DVH = cookie.substring(9, cookie.indexOf(";"));
            } else if (cookie.contains("DVH=")) {
              loginVar_DVH = cookie.substring(4, cookie.indexOf(";"));
            }
          }
        } else {
          responseCallback.call(
              this,
              createErrorResponseMap(
                  BensBucksRequestType.login, BensBucksError.connectionError));
        }

        rawLoginPage = rawLoginPage
            .substring(rawLoginPage.indexOf('name="__ncforminfo"') + 19);

        rawLoginPage =
            rawLoginPage.substring(0, rawLoginPage.indexOf("</form>"));

        loginVar_ncforminfo = rawLoginPage.substring(
            rawLoginPage.indexOf('"') + 1, rawLoginPage.lastIndexOf('"'));
      } else {
        responseCallback.call(
            this,
            createErrorResponseMap(
                BensBucksRequestType.login, BensBucksError.connectionError));
      }
    } on SocketException {
      responseCallback.call(
          this,
          createErrorResponseMap(
              BensBucksRequestType.login, BensBucksError.connectionError));
    } on TimeoutException {
      responseCallback.call(
          this,
          createErrorResponseMap(
              BensBucksRequestType.login, BensBucksError.connectionError));
    } on Error {
      responseCallback.call(
          this,
          createErrorResponseMap(
              BensBucksRequestType.login, BensBucksError.connectionError));
    }

    //Actually log in
    if (username == null || password == null) {
      username = await secureStorage.read(key: "username");
      password = await secureStorage.read(key: "password");
    }

    if (username == null || password == null) {
      responseCallback.call(
          this,
          createErrorResponseMap(BensBucksRequestType.login,
              BensBucksError.noStoredCredentialsError));
    } else {
      try {
        final loginRequest = await http
            .post(
              Uri.parse('https://fandm.campuscardcenter.com/ch/login.html'),
              headers: <String, String>{
                'Content-Type': 'application/x-www-form-urlencoded',
                'Cookie': 'DVH=' +
                    loginVar_DVH +
                    '; __utmc=230975552; BNES_DVH=' +
                    loginVar_BNES_DVH +
                    '; __utma=230975552.786452026.1630454332.1635377208.1635443301.6; __utmz=230975552.1635443301.6.6.utmcsr=fandmbensbucks.com|utmccn=(referral)|utmcmd=referral|utmcct=/',
              },
              body: "username=" +
                  username +
                  "&password=" +
                  password +
                  "&action=Login&__ncforminfo=" +
                  loginVar_ncforminfo,
            )
            .timeout(const Duration(seconds: 5));

        if (loginRequest.body != "") {
          responseCallback.call(
              this,
              createErrorResponseMap(BensBucksRequestType.login,
                  BensBucksError.invalidCredentialsError));
        } else {
          var rawCookies = loginRequest.headers["set-cookie"];

          if (rawCookies != null) {
            var cookies = rawCookies.split(",");

            for (var cookie in cookies) {
              if (cookie.contains("BNES_DVH=")) {
                loginVar_BNES_DVH = cookie.substring(9, cookie.indexOf(";"));
              } else if (cookie.contains("DVH=")) {
                loginVar_DVH = cookie.substring(4, cookie.indexOf(";"));
              } else if (cookie.contains("BNES_JSESSIONID=")) {
                loginVar_BNES_JSESSIONID =
                    cookie.substring(16, cookie.indexOf(";"));
              } else if (cookie.contains("JSESSIONID=")) {
                loginVar_JSESSIONID = cookie.substring(11, cookie.indexOf(";"));
              }
            }
          }

          await secureStorage.write(key: "username", value: username);
          await secureStorage.write(key: "password", value: password);

          loggedIn = true;

          responseCallback.call(
              this,
              createErrorResponseMap(
                  BensBucksRequestType.login, BensBucksError.noError));
        }
      } on SocketException {
        responseCallback.call(
            this,
            createErrorResponseMap(
                BensBucksRequestType.login, BensBucksError.connectionError));
      } on TimeoutException {
        responseCallback.call(
            this,
            createErrorResponseMap(
                BensBucksRequestType.login, BensBucksError.connectionError));
      } on Error {
        responseCallback.call(
            this,
            createErrorResponseMap(
                BensBucksRequestType.login, BensBucksError.connectionError));
      }
    }
  }
}
