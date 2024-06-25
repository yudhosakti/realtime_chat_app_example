import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_chat/provider/riverpod_auth.dart';
import 'package:realtime_chat/view/page/home_page.dart';
import 'package:realtime_chat/view/page/onboarding_page.dart';
import 'package:realtime_chat/view/page/register_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        "Welcome back! Glad to see you, Again!",
                        style: GoogleFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 36),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextFormWidget(
                  hinttext: "Enter Your Email",
                  isInvisible: false,
                  isUseIcons: false,
                  textEditingController: ref.read(authLoginRiverpod).etEmail,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormWidget(
                  hinttext: "Enter Your Password",
                  isInvisible: true,
                  isUseIcons: true,
                  textEditingController: ref.read(authLoginRiverpod).etPassword,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(106, 112, 124, 1)),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
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
                              .loginAction()
                              .then((value) {
                            if (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login Failed")));
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                                      MediaQuery.of(context).size.width * 0.35,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "Or Login with",
                                  style:
                                      GoogleFonts.urbanist(color: Colors.grey),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.025,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Don’t have an account?"),
                          TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.zero)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ));
                              },
                              child: Text(
                                "Register",
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

class IconCustomWidget extends StatelessWidget {
  const IconCustomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(width: 1, color: Colors.grey),
        color: Colors.white,
      ),
      child: Center(
        child: Icon(
          Icons.facebook,
          size: 42,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

class TextFormWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final bool isInvisible;
  final bool isUseIcons;
  const TextFormWidget(
      {super.key,
      required this.hinttext,
      required this.isInvisible,
      required this.isUseIcons,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: TextFormField(
          obscureText: isInvisible,
          controller: textEditingController,
          decoration: InputDecoration(
              suffixIcon: isUseIcons
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey.shade500,
                      ))
                  : null,
              hintStyle: GoogleFonts.urbanist(color: Colors.grey.shade600),
              hintText: hinttext,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12)))),
        ),
      ),
    );
  }
}
