import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_chat/data/forum_data.dart';
import 'package:realtime_chat/model/forum_model.dart';
import 'package:realtime_chat/view/page/chat/chat_page.dart';

class ChatMenuPage extends StatelessWidget {
  const ChatMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ForumData().getAllForum(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator()],
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text("No Data Yet"),
            );
          } else {
            List<ForumModel> forumData = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: forumData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(id_forum: forumData[index].idForum,image: forumData[index].gambarForum,name: forumData[index].judulForum),
                                  )),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(85, 102, 120, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.005),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    forumData[index].gambarForum),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.045,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                forumData[index].judulForum,
                                                style: GoogleFonts.urbanist(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              textAlign: TextAlign.left,
                                              forumData[index].deskripsiForum,
                                              style: GoogleFonts.urbanist(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                }, childCount: 1))
              ],
            );
          }
        });
  }
}
