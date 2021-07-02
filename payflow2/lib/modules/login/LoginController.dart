import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/AuthController.dart';
import 'package:payflow/shared/models/UserModel.dart';

class LoginController {
  final authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      authController.setUser(context,
          UserModel(name: response!.displayName!, photoUrl: response.photoUrl));
      print(response);
    } catch (error) {
      print(error);
    }
  }
}
