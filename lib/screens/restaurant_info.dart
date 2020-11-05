import 'package:FoodSight/widgets/google_map_widget.dart';
import 'package:FoodSight/widgets/star_rating_stateful.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/restaurants.dart';
import '../widgets/star_rating.dart';

class RestaurantInformation extends StatelessWidget {
  static final String routeName = "/restaurant-information";

  void onClickPhoneIcon(String phone) async {
    if (await canLaunch("tel://$phone")) {
      await launch("tel://$phone");
    } else {
      throw 'Could not launch phone $phone';
    }
  }

  void onClickEmailIcon(String email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch email $email';
    }
  }

  void onClickFacebookIcon(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onClickInstagramIcon(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final String idRestaurant =
        ModalRoute.of(context).settings.arguments as String;
    final restaurantsData = Provider.of<Restaurants>(context);
    final restaurant = restaurantsData.findById(idRestaurant);
    return Scaffold(
      appBar: AppBar(
        title: Text("${restaurant.name} Information"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  restaurant.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "${restaurant.name}",
                        style: TextStyle(
                          fontSize: 28,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).accentColor),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description:",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor:
                                              Theme.of(context).accentColor,
                                        ),
                                      ),
                                      Container(
                                        width: mediaQuery.width - 65,
                                        child: Text(
                                            "${restaurant.description} asklfjdalksjdlaksd lkasdlasdljasl kdjaslkdjalksjdlaksjdlkajsdlkasjdlk",
                                            style: TextStyle(fontSize: 20),
                                            overflow: TextOverflow.visible),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Location:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        backgroundColor:
                                            Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              child: MapRestaurantLocation(restaurant.location),
                              //   child: MapRestaurantLocation(
                              //       "13.6789672,-89.2418977"),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Contact:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => onClickPhoneIcon(
                                              restaurant.phone),
                                          child: Image.asset(
                                              "assets/icons/icons8-call-48.png"),
                                        ),
                                        InkWell(
                                          onTap: () => onClickEmailIcon(
                                              restaurant.email),
                                          child: Image.asset(
                                              "assets/icons/icons8-send-email-48.png"),
                                        ),
                                        InkWell(
                                          onTap: () => onClickFacebookIcon(
                                              restaurant.fbUrl),
                                          child: Image.asset(
                                              "assets/icons/icons8-facebook-48.png"),
                                        ),
                                        InkWell(
                                          onTap: () => onClickInstagramIcon(
                                              restaurant.instaUrl),
                                          child: Image.asset(
                                              "assets/icons/icons8-instagram-48.png"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(" ${restaurant.address}",
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(" ${restaurant.phone}",
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(" ${restaurant.email}",
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rating:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: StatefulStarRating(
                                      restaurant.rating.round(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
