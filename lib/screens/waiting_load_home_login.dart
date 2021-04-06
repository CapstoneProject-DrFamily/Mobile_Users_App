import 'package:commons/commons.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';

class WaitingLoadingHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.white,
                          height: 350.0,
                          width: double.infinity,
                          child: Image.asset(
                            LOGIN_WAVE,
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Expanded(child: Container()),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                "Getting your profile",
                                style: TextStyle(
                                    fontSize: (28 / 375.0) *
                                        MediaQuery.of(context).size.width,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue[700],
                                    height: 1.5),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.06),
                              _buildProcessField(),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _buildLogo(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Padding _buildProcessField() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
    child: JumpingText(
      '...',
      style: TextStyle(fontSize: 50),
    ),
  );
}

Positioned _buildLogo() {
  return Positioned(
    left: 0,
    top: 72,
    right: 0,
    child: Container(
      width: 150,
      height: 150,
      child: Image.asset(
        LOGIN_LOGO,
        fit: BoxFit.contain,
      ),
    ),
  );
}
