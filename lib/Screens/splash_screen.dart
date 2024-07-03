import 'package:dar_nashr_gameat_el_malek_soad/Screens/User/login_screen.dart';
import 'package:dar_nashr_gameat_el_malek_soad/cubits/cubit.dart';
import 'package:flutter/material.dart';
import '../extensions/standards.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();

    Future<void> navigate() async {
      bool loggedIn = await AppCubit.get(context).isLoggedIn();
      loggedIn
          ? Navigator.of(context).pushReplacementNamed("/basicScreen",
              arguments: await AppCubit.get(context).getCurrentUser())
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
    }

    Future.delayed(const Duration(seconds: 3), navigate);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColorDark, primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                "assets/img/logo.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "دار نشر جامعة ",
                  style: TextStyle(fontSize: 38, color: Colors.white),
                ),
                Text(
                  "الملك سعود",
                  style: TextStyle(fontSize: 38, color: Colors.white),
                ),
                SizedBox(
                  height: 35,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
