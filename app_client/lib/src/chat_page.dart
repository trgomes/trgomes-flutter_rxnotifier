import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String room;

  ChatPage({Key key, @required this.name, @required this.room});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room: ${widget.room}')),
      extendBody: true,
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, id) {
                  return ListTile(title: Text('$id'));
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type your text',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
