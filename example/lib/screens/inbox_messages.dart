import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/material.dart';

class InboxMessages extends StatefulWidget {
  const InboxMessages({super.key});

  @override
  _InboxMessagesState createState() => _InboxMessagesState();
}

class _InboxMessagesState extends State<InboxMessages> {
  List<String> selectedMessages = [];

  @override
  Widget build(BuildContext context) {
    return _buildInbox();
  }

  Widget _buildInbox() {
    return FutureBuilder<List<Message>>(
      future: Emarsys.messageInbox.fetchMessages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading messages"));
        } else if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return _buildInboxMessage(snapshot.data![index]);
            },
          );
        } else {
          return const Center(child: Text("No messages"));
        }
      },
    );
  }

  Widget _buildInboxMessage(Message message) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: selectedMessages.contains(message.id)
          ? _buildSelectedInboxMessage(message)
          : _buildUnselectedInboxMessage(message),
    );
  }

  Widget _buildSelectedInboxMessage(Message message) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 6,
        child: ListTile(
          onTap: () => _toggleMessageSelection(message.id),
          title: Text(message.title),
          subtitle: _buildMessageDetails(message),
          leading: _loadImageUrl(message.imageUrl),
        ),
      ),
    );
  }

  Widget _buildUnselectedInboxMessage(Message message) {
    return ListTile(
      onTap: () => _handleMessageSelection(message),
      title: Text(message.title),
      subtitle: Text(message.body),
      leading: _loadImageUrl(message.imageUrl),
    );
  }

  Widget _buildMessageDetails(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message.body),
        _buildMessageTags(message),
        _buildMessageActions(message),
      ],
    );
  }

  Widget _buildMessageTags(Message message) {
    return Row(
      children: [
        const Text("Tags: "),
        Text(message.tags?.join(", ") ?? "-"),
      ],
    );
  }

  Widget _buildMessageActions(Message message) {
    return Row(
      children: [
        const Text("Actions: "),
        Expanded(
          child: Text(
            message.actions?.map((action) => action.title).join(", ") ?? "-",
            maxLines: 2,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _loadImageUrl(String? url) {
    if (url != null) {
      return Image.network(url, height: 60, width: 60);
    } else {
      return Image.asset("assets/placeholder.png", height: 60, width: 60);
    }
  }

  void _handleMessageSelection(Message message) {
    setState(() {
      selectedMessages.add(message.id);
      if (!(message.tags?.contains("seen") ?? false)) {
        message.tags?.add("seen");
        Emarsys.messageInbox.addTag(message.id, "seen");
      }
    });
  }

  void _toggleMessageSelection(String messageId) {
    setState(() {
      if (selectedMessages.contains(messageId)) {
        selectedMessages.remove(messageId);
      } else {
        selectedMessages.add(messageId);
      }
    });
  }
}
