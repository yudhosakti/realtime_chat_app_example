import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_chat/view/page/login_page.dart';
import 'package:realtime_chat/view/page/register_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images3.alphacoders.com/135/1355318.jpg"),
                    fit: BoxFit.fill)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.12,
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://play-lh.googleusercontent.com/ameFGPYH-qhOSxdsSA_fA54I4Ch-eO8y7Pj4x6W6ejQkvKbhVjCehKlPerBY9X2L8ek")),
                      color: Colors.greenAccent,
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.003,
                ),
                Expanded(
                    child: Text(
                  "Wuthering Chat",
                  style: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonCustomWidget(
                  routes: LoginPage(),
                  textColor: Colors.white,
                  warnaDasar: Colors.black,
                  sideColor: Colors.black,
                  textLogin: "Login",
                ),
                ButtonCustomWidget(
                  routes: RegisterPage(),
                  textColor: Colors.black,
                  warnaDasar: Colors.white,
                  sideColor: Colors.black,
                  textLogin: "Register",
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextButton(
                      onPressed: () => {}, child: Text("Continue As Guest")),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class ButtonCustomWidget extends StatelessWidget {
  final Color warnaDasar;
  final Color textColor;
  final Widget routes;
  final String textLogin;
  final Color sideColor;
  const ButtonCustomWidget(
      {super.key,
      required this.routes,
      required this.textColor,
      required this.textLogin,
      required this.sideColor,
      required this.warnaDasar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        child: ElevatedButton(
            style: ButtonStyle(
                side: MaterialStatePropertyAll(
                    BorderSide(color: sideColor, width: 2)),
                overlayColor: MaterialStatePropertyAll(Colors.white70),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
                backgroundColor: MaterialStatePropertyAll(warnaDasar)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => routes,
                  ));
            },
            child: Text(
              textLogin,
              style: GoogleFonts.urbanist(
                  color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
            )),
      ),
    );
  }
}
