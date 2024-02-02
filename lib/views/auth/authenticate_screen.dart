import 'package:flutter/material.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/auth/auth_repository.dart';
import 'package:invoder_app/data/models/auth_models.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    Future(() async {
      if (box.read('token') != null) {
        final authRepository = AuthRepository();
        final result = await authRepository.authenticate();
        if (result.error) {
          box.remove('user');
          await authRepository.logout();
        } else {
          var data = UserModel.fromMap(result.data);
          box.write('user', data);
          if (data.company == null) {
            Get.offAllNamed('/business-detail');
            return;
          }
          Get.offAllNamed('/home');
        }
      } else {
        Get.offAllNamed('/login');
      }
    });
    return Scaffold(
      appBar: emptyAppBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70.0,
                width: 70.0,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Loading Dashboard...',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
