import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/Screens/login.dart';
import '/Screens/signup.dart';

import '/constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white70 ,
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO ICU MONITOR",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Always Care and Monitor ",
              style: TextStyle(fontWeight: FontWeight.normal,color:Colors.orange[300],fontSize: 14.0),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset('assets/ICU.png',height: 100,
              width: 100),

            SizedBox(height: size.height * 0.05),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: ElevatedButton(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: kPrimaryLightColor)

                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: ElevatedButton(
                      child: Text(
                        "SIGN UP",
                          style: TextStyle(color: kPrimaryColor)
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryLightColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ))),
          ],
        ),
      ),
    ));
  }
}
