import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_chat/provider/riverpod_auth.dart';
import 'package:realtime_chat/view/page/home_page.dart';
import 'package:realtime_chat/view/page/login_page.dart';
import 'package:realtime_chat/view/page/onboarding_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ))),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.018),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Center(
                      child: Text(
                        "Hello! Register to get started",
                        style: GoogleFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 36),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormWidget(
                    hinttext: "Username",
                    isInvisible: false,
                    isUseIcons: false,
                    textEditingController: ref.read(authLoginRiverpod).etUsernameRegister),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormWidget(
                    hinttext: "Email",
                    isInvisible: false,
                    isUseIcons: false,
                    textEditingController: ref.read(authLoginRiverpod).etEmailRegister),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormWidget(
                    hinttext: "Password",
                    isInvisible: true,
                    isUseIcons: false,
                    textEditingController: ref.read(authLoginRiverpod).etPasswordRegiser),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormWidget(
                    hinttext: "Confirm Password",
                    isInvisible: true,
                    isUseIcons: false,
                    textEditingController: ref.read(authLoginRiverpod).etConfirmPasswordRegiser),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            side: MaterialStatePropertyAll(
                                BorderSide(color: Colors.black, width: 2)),
                            overlayColor:
                                MaterialStatePropertyAll(Colors.white70),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)))),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                        onPressed: () async {
                          await ref
                              .read(authLoginRiverpod)
                              .registerUser()
                              .then((value) {
                            if (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(ref.read(authLoginRiverpod).errorMessage)));
                            }
                          });
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "Or Register with",
                                  style:
                                      GoogleFonts.urbanist(color: Colors.grey),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Expanded(
                          child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconCustomWidget(),
                            IconCustomWidget(),
                            IconCustomWidget()
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(child: Text("Already have an account?")),
                          TextButton(
                              style: ButtonStyle(
                                  alignment: Alignment.centerLeft,
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(53, 194, 193, 1)),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}
