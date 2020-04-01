import 'package:auto_size_text/auto_size_text.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class RestaurantDescriptionScreen extends StatefulWidget {
  RestaurantDescriptionScreen({this.place});

  static const String id = 'restaurant_description_screen';
  final PlacesSearchResult place;

  @override
  _RestaurantDescriptionScreenState createState() =>
      _RestaurantDescriptionScreenState();
}

class _RestaurantDescriptionScreenState
    extends State<RestaurantDescriptionScreen> {
  String photoRef;
  String ratingStars;
  String priceDollars;
  String openStatus;
  List<String> openingDetail;

  getPlaceDetails() async {
    try {
      final PlacesDetailsResponse placeDetails =
          await GoogleMapsPlaces().getDetailsByPlaceId(widget.place.id);
      setState(() {
        openingDetail = placeDetails.result.openingHours.weekdayText;
      });
      print(openingDetail);
    } catch (e) {
      print(e);
    }
  }

  getOpenCloseStatus(bool isClosed) {
    if (isClosed == null) return "No status found!";
    if (isClosed) return "Permanently Closed";
    return "Open!";
  }

  getPriceDollars(PriceLevel priceLevel) {
    if (priceLevel == PriceLevel.free) return "Free";
    if (priceLevel == PriceLevel.inexpensive) return "\$";
    if (priceLevel == PriceLevel.moderate) return "\$\$";
    if (priceLevel == PriceLevel.expensive) return "\$\$\$";
    if (priceLevel == PriceLevel.veryExpensive) return "\$\$\$\$";
  }

  getRatingStars(double ratingDouble) {
    if (ratingDouble <= 0.0) return "No Ratings yet!";
    if (ratingDouble < 2.0) return "★";
    if (ratingDouble < 3.0) return "★★";
    if (ratingDouble < 4.0) return "★★★";
    if (ratingDouble < 4.9)
      return "★★★★";
    else
      return "★★★★★";
  }

  @override
  Widget build(BuildContext context) {
    getPlaceDetails();
    if (widget.place != null) {
      photoRef = widget.place.photos[0].photoReference;
      ratingStars = getRatingStars(widget.place.rating.toDouble());
      priceDollars = getPriceDollars(widget.place.priceLevel);
      openStatus = getOpenCloseStatus(widget.place.permanentlyClosed);
      print(openingDetail);
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.redAccent,
        ),
        title: AutoSizeText(
          'Donde',
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: kTitleTextStyle.copyWith(
              color: Colors.redAccent, fontStyle: FontStyle.normal),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Title with icon
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Tab(
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Image(
                              image: AssetImage(
                                'images/logo.png',
                              ),
                              fit: BoxFit.cover,
                            ),
//                        height: 45,
//                        width: 45,
                          ),
                        ),
                      ),
                    ),
//                  Expanded(
//                    flex: 1,
//                    child: SizedBox(
//                      width: 10.0,
//                    ),
//                  ),
                    Flexible(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: AutoSizeText(
                          widget.place != null
                              ? this.widget.place.name
                              : "Restaurant Name",
                          style: kTitleTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Restaurant card
            Flexible(
              flex: 6,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Image.network(
                            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=AIzaSyA-uiBKbMxCqyMR6JqbfB-VnDAHL8tFx6U',
                            width: double.maxFinite,
                            height: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Rating: ",
                                        style: kResDescriptionTextStyle,
                                      ),
                                      Text(
                                        ratingStars != null
                                            ? this.ratingStars
                                            : 'No Rating Available',
                                        style: kResDescriptionTextStyle
                                            .copyWith(color: Color(0xffebca46)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Price Level: ",
                                        style: kResDescriptionTextStyle,
                                      ),
                                      Text(
                                        priceDollars != null
                                            ? this.priceDollars
                                            : 'No Price information Available',
                                        style:
                                            kResDescriptionTextStyle.copyWith(
                                          color: Color(0xff35852c),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Status: ",
                                        style: kResDescriptionTextStyle,
                                      ),
                                      Text(
                                        openStatus,
                                        style:
                                            kResDescriptionTextStyle.copyWith(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: AutoSizeText(
                                          "Opening Hours: ",
                                          style: kResDescriptionTextStyle,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: AutoSizeText(
                                          openingDetail != null
                                              ? openingDetail[0]
                                              : "No details",
                                          maxLines: 2,
                                          maxFontSize: 15,
                                          minFontSize: 2,
                                          overflow: TextOverflow.clip,
                                          style:
                                              kResDescriptionTextStyle.copyWith(
                                                  color: Colors.black38,
                                                  fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      AutoSizeText(
                                        "Vicinity: ",
                                        style: kResDescriptionTextStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                      AutoSizeText(
                                        widget.place.vicinity != null
                                            ? this.widget.place.vicinity
                                            : 'No Vicinity information Available',
                                        maxLines: 2,
                                        maxFontSize: 15,
                                        minFontSize: 2,
                                        overflow: TextOverflow.clip,
                                        style:
                                            kResDescriptionTextStyle.copyWith(
                                                color: Colors.black38,
                                                fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
