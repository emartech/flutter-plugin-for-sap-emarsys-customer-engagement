import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/material.dart';

class InboxMessages extends StatelessWidget {
  const InboxMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return inbox();
  }
}

Widget inbox() {
  return FutureBuilder<List<Message>>(
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Container(
              child: ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].body),
                      leading: loadImageUrl(snapshot.data![index].imageUrl),
                    );
                  }));
        } else {
          return Center(child: Text("No messages"));
        }
      },
      future: Emarsys.messageInbox.fetchMessages());
}

Widget loadImageUrl(String? url) {
  if (url != null) {
    return Image.network(url, height: 60, width: 60);
  } else {
    return Image.asset("placeholder.png", height: 60, width: 60);
  }
}
