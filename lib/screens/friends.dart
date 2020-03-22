import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:donde_app/contactsClass.dart';
import 'package:flutter/material.dart';
import 'package:donde_app/contactsClass.dart';
import '../constants.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        body: Center(child: SwipeList()));
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  List items = [];

  @override
  void initState() {
    super.initState();
    getFriends();
  }

  void getFriends() async {
    print('CONTACTS here!');
    List<Contact> contacts = await ContactsClass.getContacts();
    List<String> list = List();
    for (var i in contacts) {
      i.phones.forEach((phoneNum) async {
        print(phoneNum.value.replaceAll(" ", ""));
        QuerySnapshot query = await Firestore.instance
            .collection('users')
            .where('phoneNo', isEqualTo: phoneNum.value.replaceAll(" ", ""))
            .getDocuments();

        for (var document in query.documents) {
          print(document.documentID);
          print(document.data);
          setState(() {
            this.items.add(document.data['displayName']);
          });

        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index]),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });
          },
          direction: DismissDirection.endToStart,
          child: Card(
            elevation: 10,
            child: Container(
              height: 90.0,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://i.ya-webdesign.com/images/funny-png-avatar-2.png"))),
                  ),
                  Container(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            items[index],
                            style: TextStyle(
                              fontSize: 25,
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
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                            child: Container(
                              width: 260,
                              child: Text(
                                "It is tasty",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic,
                                  //color: Colors.redAccent,
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
