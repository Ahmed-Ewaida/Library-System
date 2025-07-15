import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/Authontication/views/screens/login_screen.dart';
import '../../../../features/Authontication/views/screens/register_screen.dart';

import '../../../../Core/widget/constant.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = "/";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/img_1.png', fit: BoxFit.cover),
          ),
          const SizedBox(height: 300),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text(
                          AppText.app_name,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'RobotoSlab',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.black,
                          ),
                        ),
                        Text(
                          AppText.app_name,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'RobotoSlab',
                            color: const Color(0XFF095994),
                            shadows: [
                              Shadow(
                                blurRadius: 2,
                                color: Colors.grey.withOpacity(0.9),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        // height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(RegisterScreen.id);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(7),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              AppText.register_text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0XFF095994),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        // height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(LoginScreen.id);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(7),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              AppText.login_text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0XFF095994),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
