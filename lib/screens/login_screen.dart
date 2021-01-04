import 'package:drFamily_app/links/links.dart';
import 'package:drFamily_app/screens/home_page.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MainColors.kMainBody,
      body: NotificationListener<OverscrollIndicatorNotification>(
        // onNotification: (overscroll) {
        //   overscroll.disallowGlow();
        // },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.75,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.0, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [MainColors.blueBegin, MainColors.blueEnd],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // transform:
                        //     Matrix4.translationValues(0.0, 20.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            right: 30.0,
                          ),
                          child: Image.network(
                            ImagesLinks.wordLogoLink,
                            width: 250.0,
                            height: 150.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                        margin: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: MainColors.white,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 50.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20.0,
                                left: 20.0,
                                right: 20.0,
                                bottom: 20.0,
                              ),
                              child: TextFormField(
                                // controller: emailTextEditingController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+|.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Please enter a valid email address";
                                },
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'email@emailaddress.com',
                                  hintStyle: TextStyle(
                                    color: MainColors.hintTextColor,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 0.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MainColors.iconLoginColor,
                                        width: 0.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20.0,
                                      left: 10.0,
                                      bottom: 1.0,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: MainColors.iconLoginColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 20.0,
                              ),
                              child: TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  return val.length > 6
                                      ? null
                                      : "Password must be greater than 6 characters";
                                },
                                // controller: passwordTextEditingController,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: MainColors.hintTextColor,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 0.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MainColors.iconLoginColor,
                                        width: 0.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20.0,
                                      left: 10.0,
                                      bottom: 1.0,
                                    ),
                                    child: Icon(
                                      Icons.lock_outline,
                                      color: MainColors.iconLoginColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 90.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: RaisedButton(
                    color: MainColors.riseButtonBlue,
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: RaisedButton(
                    color: MainColors.riseButtonRed,
                    padding: EdgeInsets.all(15),
                    onPressed: () {},
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Login with Phone',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
