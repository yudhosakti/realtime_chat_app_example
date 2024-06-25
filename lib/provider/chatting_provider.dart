import 'package:flutter/material.dart';
import 'package:realtime_chat/model/chat_model.dart';

class ChattingProvider extends ChangeNotifier {
  List<ChatModel> chatAwal = [];

  void updateMessage(ChatModel newChat) {
    chatAwal.add(newChat);
    notifyListeners();
  }

  void addAllChat(List<ChatModel> newChats) {
    chatAwal = [];
    for (var element in newChats) {
      chatAwal.add(element);
    }
    chatAwal =  chatAwal.reversed.toList();
  }
}
