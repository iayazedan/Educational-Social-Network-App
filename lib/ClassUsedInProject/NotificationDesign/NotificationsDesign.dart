import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unisocial/ClassUsedInProject/NotificationDesign/getNotifications.dart';
class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('notification').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Container(
      key: ValueKey(record.name),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => getNotifications("25")));
        },
        child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin:EdgeInsets.only(top: 9,right: 10,left: 6),
                    alignment: Alignment.centerLeft,
                    width: 50,
                    height:50,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/avatar.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${record.name}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text("time",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.pinkAccent.shade100,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:60),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                         child:Text(
                            "${record.notification}",
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                           textAlign: TextAlign.left,
                          ),

                      ),
                    ),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final String notification;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['notification'] != null),
        name = map['name'],
        notification = map['notification'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$notification>";
}

//   ListTile(
//    title: Text(record.name),
//    trailing: Text(record.notification.toString()),
//    onTap: () => Firestore.instance.runTransaction((transaction) async {
//          final freshSnapshot = await transaction.get(record.reference);
//          final fresh = Record.fromSnapshot(freshSnapshot);

//          await transaction
//              .update(record.reference, {'notification': fresh.notification + '.'});
//        }),
//  ),
