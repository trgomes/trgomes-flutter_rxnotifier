import 'package:app_client/src/chat_controller.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String room;

  ChatPage({Key key, @required this.name, @required this.room});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = ChatController(widget.room, widget.name);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room: ${widget.room}')),
      extendBody: true,
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            RxBuilder(builder: (_) {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.listEvent.length,
                  itemBuilder: (_, id) {
                    final event = controller.listEvent[id];

                    if (event.type == SocketEventType.enter_room) {
                      return ListTile(
                        title: Text('${event.name} ENTROU NA SALA!'),
                      );
                    } else if (event.type == SocketEventType.leave_room) {
                      return ListTile(
                        title: Text('${event.name} SAIU DA SALA!'),
                      );
                    }

                    return ListTile(
                      title: Text(event.name),
                      subtitle: Text(event.text),
                    );
                  },
                ),
              );
            }),
            TextField(
              onSubmitted: (_) => controller.send(),
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: 'Type your text',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: controller.send,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
