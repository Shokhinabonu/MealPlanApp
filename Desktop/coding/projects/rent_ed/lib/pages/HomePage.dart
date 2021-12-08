import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:rent_ed/helpers/utils.dart';
import 'package:rent_ed/models/Property.dart';
import 'package:rent_ed/widgets/ListingCards.dart';
import 'package:rent_ed/widgets/MiniatureListingCards.dart';
import 'package:rent_ed/widgets/NavigationBar.dart';
import 'package:rent_ed/models/Profile.dart';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Property> listings =
      Utils.getListing(); //pass it to the Card as a parameter
  Profile currentUser = Utils.getProfile();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                child: Stack(
                  children: [
                    Positioned(
                        child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30.0,
                      backgroundImage: AssetImage(currentUser.image),
                    )),
                    Positioned(
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 30,
                      ),
                      left: 95,
                      top: 12,
                    ),
                    Positioned(
                      child: Text(
                        currentUser.location,
                        style: TextStyle(fontSize: 20),
                      ),
                      left: 130,
                      top: 15,
                    ),
                    Positioned(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 35,
                      ),
                      left: 248,
                      top: 10,
                    ),
                    Positioned(
                      child: Icon(
                        Icons.notifications_none,
                        size: 35,
                      ),
                      left: 298,
                      top: 10,
                    ),
                    Positioned(
                      child: Icon(
                        Icons.settings,
                        size: 35,
                      ),
                      left: 350,
                      top: 10,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  'Hello ' + currentUser.firstName + '!',
                  style: GoogleFonts.rubik(
                      fontSize: 25,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(top: 5),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 25),

                child: Text(
                  'Start looking for your house',
                  style: GoogleFonts.rubik(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.search_sharp,
                      size: 40,
                      color: Colors.blueGrey,
                    ),
                    title: Text(
                      'What are you looking for?',
                      style: GoogleFonts.rubik(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w300),
                    ),
                    trailing: Icon(
                      Icons.filter_list_sharp,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                          child: Text(
                            'Nearby Options',
                            style: GoogleFonts.rubik(
                                fontSize: 25,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        MiniatureListingCards(listings),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                          child: Text(
                            'Favourites',
                            style: GoogleFonts.rubik(
                                fontSize: 25,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        ListingCards(listings),
                      ],
                    )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(),
      ),
    );
  }
}
