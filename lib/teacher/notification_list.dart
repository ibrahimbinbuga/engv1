import 'package:engv1/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationList createState() => _NotificationList();
}

class _NotificationList extends State<NotificationList> {
  final notificationStream =
      FirebaseFirestore.instance.collection("teacher").snapshots();
  bool starred = false;
  Api _api = new Api();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: StreamBuilder(
          stream: notificationStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Connection Error"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );

            }
            var docs = snapshot.data!.docs;
            if (docs.length == 0) {
              return Center(child: Text("There is not any notification"));
            }
            // return Text('${docs.length}');
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: docs.length,


                itemBuilder: (context, index) {

                  return ListTile(
                      title: Text(docs[index]['header']),
                      subtitle: Text(_api.convertDateTimeDisplay(
                          '${DateUtils.dateOnly(docs[index]["date"].toDate())}')),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children:
                      [
                        IconButton(onPressed: () async {
                          DocumentSnapshot? ds = snapshot.data!.docs[index];

                          _api.delete(ds!,'teacher');
                        },
                            icon: Icon(Icons.delete_forever)),
                      ]),
                      onTap: () {
                        //Open a pop up to show the message
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _api.notification(context, index, docs);
                            });
                      });
                });
          },
        ));
  }
}
