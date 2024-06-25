import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_chat/provider/riverpod_bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(
          Icons.chat,
          color: Colors.white,
        ),
        title: Text(
          "Home Page",
          style: GoogleFonts.urbanist(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Consumer(
        builder: (context, ref, child) => ref
            .watch(bottomNavRiverpod)
            .menu[ref.watch(bottomNavRiverpod).currentIndex],
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.shifting,
              elevation: 10,
              currentIndex: ref.watch(bottomNavRiverpod).currentIndex,
              onTap: (value) {
                ref.read(bottomNavRiverpod).changeMenu(value);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: "Chats",
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group),
                    label: "Groups",
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.more_horiz),
                    label: "More",
                    backgroundColor: Colors.black)
              ]),
        );
      }),
    );
  }
}
