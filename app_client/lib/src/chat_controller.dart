import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:common/common.dart';

class ChatController {
  Socket socket;
  final String room;
  final String name;
  final listEvent = RxList<SocketEvent>([]);
  final textController = TextEditingController(text: '');
  final focusNode = FocusNode();

  ChatController(this.room, this.name) {
    _init();
  }

  void _init() {
    socket = io(
      API_URL,
      OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.connect();

    socket.onConnect((data) {
      socket.emit('enter_room', {'room': room, 'name': name});
    });

    socket.on('message', (data) {
      final event = SocketEvent.fromJson(data);
      listEvent.add(event);
    });
  }

  void send() {
    final event = SocketEvent(
      name: name,
      room: room,
      text: textController.text,
      type: SocketEventType.message,
    );

    listEvent.add(event);
    socket.emit('message', event.toString());
    textController.clear();
    focusNode.requestFocus();
  }

  void dispose() {
    socket.clearListeners();
    socket.close();
    textController.dispose();
    focusNode.dispose();
  }
}
