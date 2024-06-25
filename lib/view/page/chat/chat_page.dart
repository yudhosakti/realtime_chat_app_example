import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_chat/data/forum_data.dart';
import 'package:realtime_chat/model/chat_model.dart';
import 'package:realtime_chat/provider/chatting_provider.dart';
import 'package:realtime_chat/provider/riverpod_auth.dart';
import 'package:realtime_chat/provider/riverpod_chatting.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends ConsumerStatefulWidget {
  final int id_forum;
  final String name;
  final String image;
  const ChatPage(
      {super.key,
      required this.id_forum,
      required this.image,
      required this.name});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  TextEditingController textEditingController = TextEditingController();
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  void initializeSocket() {
    socket = IO.io('http://localhost:4000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.onConnect((_) {
      log('Connected to the server');
      socket.emit('msg', 'Hello from Flutter');
    });

    socket.onDisconnect((_) {
      log('Disconnected from the server');
    });

    socket.on('newMessage', (data) {
      log('New message from server: $data');
      ref.read(chattingRiverpod).updateMessage(ChatModel.fromJSON(data));
    });
  }

  double getWidth() {
    FlutterView view = PlatformDispatcher.instance.views.first;

    double physicalWidth = view.physicalSize.width;

    double devicePixelRatio = view.devicePixelRatio;

    double screenWidth = physicalWidth / devicePixelRatio;
    return screenWidth;
  }

  double getHeight() {
    FlutterView view = PlatformDispatcher.instance.views.first;
    double physicalHeight = view.physicalSize.height;

    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    return screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        flexibleSpace: SafeArea(
          child: Container(
            width: getWidth() * 0.2,
            height: getHeight(),
            child: Row(
              children: [
                SizedBox(
                  width: getWidth() * 0.12,
                ),
                Container(
                  width: getWidth() * 0.18,
                  height: getHeight() * 0.07,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  width: getWidth() * 0.01,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the text vertically
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: getHeight() * 0.005,
                      ),
                      Text(
                        "Last Update 18.45",
                        style: GoogleFonts.urbanist(
                            color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        elevation: 10,
        backgroundColor: Color.fromRGBO(62, 70, 79, 1),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                SizedBox(
                  height: getHeight() * 0.01,
                ),
                FutureBuilder(
                    future: ForumData().getAllForumMessage(widget.id_forum),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        ref.read(chattingRiverpod).addAllChat(snapshot.data!);
                        return Consumer(builder: (context, ref, child) {
                          final ChattingProvider chattingProvider =
                              ref.watch(chattingRiverpod);
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: chattingProvider.chatAwal.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getWidth() * 0.03,
                                ),
                                child: chattingProvider
                                            .chatAwal[index].id_user ==
                                        ref
                                            .read(authLoginRiverpod)
                                            .userLoginNow!
                                            .idUser
                                    ? SenderWidget(
                                        chatModel:
                                            chattingProvider.chatAwal[index],
                                      )
                                    : ReceiverWidget(
                                        chatModel:
                                            chattingProvider.chatAwal[index]),
                              );
                            },
                          );
                        });
                      }
                    }),
                SizedBox(
                  height: getHeight() * 0.1,
                )
              ],
            );
          }, childCount: 1))
        ],
      ),
      bottomSheet: Container(
        width: getWidth(),
        height: getHeight() * 0.08,
        color: Colors.black.withOpacity(0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getWidth() * 0.005,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getHeight() * 0.01, horizontal: getWidth() * 0.01),
              child: Container(
                width: getWidth() * 0.85,
                height: getHeight(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.01),
                  child: TextFormField(
                    controller: textEditingController,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan Pesan",
                        hintStyle: GoogleFonts.poppins(color: Colors.grey)),
                  ),
                ),
              ),
            ),
            Center(
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    socket.emit(
                        'sendMessage',
                        ChatModel(
                          id_forum: widget.id_forum,
                                name: ref
                                    .read(authLoginRiverpod)
                                    .userLoginNow!
                                    .username,
                                id_chat: 1,
                                id_user: ref
                                    .read(authLoginRiverpod)
                                    .userLoginNow!
                                    .idUser,
                                message: textEditingController.text,
                                send_at: "2024-08-08")
                            .toJSON());
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class SenderWidget extends StatelessWidget {
  final ChatModel chatModel;
  const SenderWidget({super.key, required this.chatModel});

  double getWidth() {
    FlutterView view = PlatformDispatcher.instance.views.first;

    double physicalWidth = view.physicalSize.width;

    double devicePixelRatio = view.devicePixelRatio;

    double screenWidth = physicalWidth / devicePixelRatio;
    return screenWidth;
  }

  double getHeight() {
    FlutterView view = PlatformDispatcher.instance.views.first;
    double physicalHeight = view.physicalSize.height;

    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    return screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(),
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        minHeight: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: getHeight() * 0.005,
          ),
          Container(
            constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: getWidth() * 0.5,
                minHeight: getHeight() * 0.03,
                maxHeight: double.infinity),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.02),
              child: Text(
                chatModel.message,
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: getHeight() * 0.005,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.005),
            child: Text(
              chatModel.send_at,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class ReceiverWidget extends StatelessWidget {
  final ChatModel chatModel;
  const ReceiverWidget({super.key, required this.chatModel});

  double getWidth() {
    FlutterView view = PlatformDispatcher.instance.views.first;

    double physicalWidth = view.physicalSize.width;

    double devicePixelRatio = view.devicePixelRatio;

    double screenWidth = physicalWidth / devicePixelRatio;
    return screenWidth;
  }

  double getHeight() {
    FlutterView view = PlatformDispatcher.instance.views.first;
    double physicalHeight = view.physicalSize.height;

    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    return screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(),
      constraints: BoxConstraints(minHeight: 0, maxHeight: double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getHeight() * 0.03,
            constraints:
                BoxConstraints(maxWidth: getWidth() * 0.4, minWidth: 0),
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getHeight() * 0.004,
                  horizontal: getWidth() * 0.005),
              child: Text(
                chatModel.name,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: getHeight() * 0.005,
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: double.infinity,
                minHeight: getHeight() * 0.03,
                maxWidth: getWidth() * 0.5,
                minWidth: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.015),
              child: Text(chatModel.message),
            ),
          ),
          SizedBox(
            height: getHeight() * 0.005,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.005),
            child: Text(
              chatModel.send_at,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
