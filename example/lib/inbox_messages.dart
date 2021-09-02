import 'package:emarsys_sdk/api/emarsys.dart';
import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/material.dart';

class InboxMessages extends StatefulWidget {
  const InboxMessages({Key? key}) : super(key: key);

  @override
  _InboxMessagesState createState() => _InboxMessagesState();
}

class _InboxMessagesState extends State<InboxMessages> {
  List<String> selectedMessages = [];
  @override
  Widget build(BuildContext context) {
    return inbox();
  }

  Widget inbox() {
    return FutureBuilder<List<Message>>(
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Container(
                child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return buildInboxMessage(snapshot.data![index]);
                    }));
          } else {
            return Center(child: Text("No messages"));
          }
        },
        future: Emarsys.messageInbox.fetchMessages());
  }

  Widget buildInboxMessage(Message message) {
    return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return FadeTransition(child: child, opacity: animation);
        },
        duration: Duration(milliseconds: 200),
        child: selectedMessages.contains(message.id)
            ? _buildSelectedInboxMessage(message)
            : _buildUnSelectedInboxMessage(message));
  }

  _buildSelectedInboxMessage(Message message) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 6,
        child: ListTile(
          onTap: () {
            setState(() {
              selectedMessages.remove(message.id);
            });
          },
          title: Text(message.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.body),
              Row(
                children: [
                  Text("tags: "),
                  Text(message.tags?.join(",") ?? "-"),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("actions: "),
                  Expanded(
                    child: Text(
                      message.actions
                              ?.map((action) => action.title)
                              .toList()
                              .join(",") ??
                          "-",
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          leading: _loadImageUrl(message.imageUrl),
        ),
      ),
    );
  }

  _buildUnSelectedInboxMessage(Message message) {
    return ListTile(
      onTap: () {
        setState(() {
          selectedMessages.add(message.id);
        });
        if (!(message.tags?.contains("seen") ?? false)) {
          setState(() {
            message.tags?.add("seen");
          });
          Emarsys.messageInbox.addTag(message.id, "seen");
        }
      },
      title: Text(message.title),
      subtitle: Text(message.body),
      leading: _loadImageUrl(message.imageUrl),
    );
  }

  Widget _loadImageUrl(String? url) {
    if (url != null) {
      return Image.network(url, height: 60, width: 60);
    } else {
      return Image.asset("placeholder.png", height: 60, width: 60);
    }
  }
}
