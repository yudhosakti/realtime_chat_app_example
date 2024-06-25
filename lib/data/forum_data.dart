import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:realtime_chat/model/chat_model.dart';
import 'package:realtime_chat/model/forum_model.dart';

class ForumData {
  String baseIp = "http://localhost:4000";
  Future<List<ForumModel>> getAllForum() async {
    List<ForumModel> forumData = [];
    var response = await http.get(Uri.parse("$baseIp/forum"));
    if (response.statusCode == 200) {
      var jsonDatas = jsonDecode(response.body);
      List<dynamic> jsonMapData = (jsonDatas as Map<String, dynamic>)['data'];
      forumData = [];
      for (var element in jsonMapData) {
        forumData.add(ForumModel.getDataFromJSON(element));
      }
      return forumData;
    } else {
      forumData = [];
      return forumData;
    }
  }

  Future<List<ChatModel>> getAllForumMessage(int id_forum) async {
    List<ChatModel> chatForum = [];
    var response =
        await http.get(Uri.parse("$baseIp/forum/message/all?id=${id_forum}"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> jsonMapping = (jsonData as Map<String, dynamic>)['data'];
      for (var element in jsonMapping) {
        chatForum.add(ChatModel.fromJSON(element));
      }
      return chatForum;
    } else {
      return chatForum;
    }
  }
}
