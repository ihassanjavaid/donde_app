import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donde_app/services/firestore_service.dart';
import 'package:donde_app/utilities/user_data.dart';
import 'package:flutter/material.dart';

import 'friend_details_screen.dart';

class Friends extends StatelessWidget {
  static const String id = 'friends_tab';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.redAccent,
        ),
        backgroundColor: Colors.white,
        title: AutoSizeText(
          'Friends',
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            color: Colors.redAccent,
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: SwipeList(),
      ),
    );
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  List friendsDataList = [];
  UserData userData;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    getFriends();
    super.initState();
  }

  void getFriends() async {
    String reducedPhoneNum;
    List<Contact> contacts = await ContactsClass.getContacts();

    for (var contact in contacts) {
      contact.phones.forEach((phoneNum) async {
        reducedPhoneNum = phoneNum.value.replaceAll(" ", "");
        reducedPhoneNum = reducedPhoneNum.replaceAll("-", "");

        final QuerySnapshot query =
            await _firestoreService.getUserDocuments(reducedPhoneNum);

        for (var document in query.documents) {
          setState(() {
            this.friendsDataList.add(document.data);
          });
        }
        print('Total friends:');
        print(this.friendsDataList.length);
      });
    }
  }

  void _acquireUserData() async {
    final data = await _firestoreService.getCurrentUserData();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    _acquireUserData();
    return Container(
        child: ListView.builder(
      itemCount: friendsDataList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FriendDetails(
                  phoneNumber: friendsDataList[index]['phoneNo'],
                  name: friendsDataList[index]['displayName'],
                ),
              ),
            );
          },
          child: Card(
            elevation: 10,
            child: Container(
              height: 90.0,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    child: CircularProfileAvatar(
                      "",
                      backgroundColor: Colors.grey,
                      initialsText: Text(
                        friendsDataList[index] != null
                            ? friendsDataList[index]['displayName'][0]
                            : 'A',
                        style: TextStyle(
                          fontSize: 42,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      elevation: 10.0,
                    ),
                  ),
                  Container(
                    //width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText(
                            friendsDataList[index] != null
                                ? friendsDataList[index]['displayName']
                                : 'Anonymous User',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.italic,
                              color: Colors.redAccent,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            child: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                "Online",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                "Tap to view liked restaurants",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
