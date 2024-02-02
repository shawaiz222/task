import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeAuthScreen extends StatefulWidget {
  const WelcomeAuthScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeAuthScreen> createState() => _WelcomeAuthScreenState();
}

class _WelcomeAuthScreenState extends State<WelcomeAuthScreen> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/welcome.svg',
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Welcome to Invoder',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Sign in',
                        onPressed: () {
                          box.write('new_user', false);
                          Get.toNamed('/login');
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: 'Create Account',
                        onPressed: () {
                          box.write('new_user', false);
                          Get.toNamed('/signup');
                        },
                        variant: CustomButtonVariant.gray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
