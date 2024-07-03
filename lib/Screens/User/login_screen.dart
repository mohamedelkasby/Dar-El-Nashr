import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _userKey = GlobalKey<FormFieldState>();
  final _passKey = GlobalKey<FormFieldState>();
  late final int userIndex;
  // String? userError;
  String? passError;
  // late int indexOfAcount;

  int canAuth = -10;
  Future<void> authorizeCheck() async {
    canAuth = await AppCubit.get(context).authenticate();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ///////////////////////////   for auth fingerprint
    if (AppCubit.get(context).canCheckBiometrics) {
      authorizeCheck();
      if (canAuth >= 0) {
        Navigator.pushReplacementNamed(context, "basicScreen");
      } else {
        SnackBar(content: Text("error authontication"));
      }
    }
    ////////////////////////////////////
    // AppCubit.get(context).authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                      context.watch<AppCubit>().themeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode),
                  onPressed: () {
                    AppCubit.get(context).changeTheme();
                  },
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Image.asset(
                  AppCubit.get(context).themeMode == ThemeMode.light
                      ? "assets/img/logo.png"
                      : "assets/img/logoDark.png",
                  fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width * .6,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /////////////Start/////////////////
                  TextFormField(
                    key: _userKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["please_enter_your_name"]!;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _userKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      enabledBorder: UnderlineInputBorder(),
                      disabledBorder: UnderlineInputBorder(),
                      labelText: TranslationWidget().translations[
                          AppCubit.get(context).lang]!["user_name"]!,
                      // errorText: userError,
                    ),
                  ),

                  /////////////end////////////////////

                  const SizedBox(height: 20),
                  TextFormField(
                    key: _passKey,
                    obscureText: hidePass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["please_enter_your_password"]!;
                      } else if (value.length < 8) {
                        //
                        return TranslationWidget()
                                .translations[AppCubit.get(context).lang]![
                            "password_can't_be_less_than_8_characters"]!;
                      } else if (!RegExp(r"^[a-zA-Z0-9&+@#=]+$")
                          .hasMatch(value)) {
                        return TranslationWidget()
                                .translations[AppCubit.get(context).lang]![
                            "Please_enter_only_alphanumeric_characters"]!;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _passKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key_outlined),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePass = !hidePass;
                              });
                            },
                            icon: Icon(hidePass
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        enabledBorder: const UnderlineInputBorder(
                            // borderRadius: BorderRadius.circular(5),
                            ),
                        labelText: TranslationWidget().translations[
                            AppCubit.get(context).lang]!["password"]!,
                        errorText: passError),
                  ),

                  /////////////end////////////////////

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                        TranslationWidget().translations[
                            AppCubit.get(context).lang]!["forget_password"]!,
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      ///////// when press on the login button ////////////
                      onPressed: () async {
                        // UsersAccount userData = user1; // this is not profisional

                        var username = _userKey.currentState!.value;
                        var password = _passKey.currentState!.value;
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          int checker = AppCubit.get(context).checkForLoginData(
                              username: username, password: password);
                          if (checker.isNegative) {
                            // print("password or user name is not correct");
                            // userError = null;
                            passError = TranslationWidget()
                                    .translations[AppCubit.get(context).lang]![
                                "password_or_user_name_is_not_correct"]!;
                            // setState(() {});
                          }
                          //  else if (checker == 2) {
                          //   print('Invalid userName');
                          //   userError = "invalid user name";
                          //   passError = null;
                          //   setState(() {});
                          // }
                          else if (checker >= 0) {
                            passError = null;
                            UsersAccount userData = users[checker];

                            /// should use email instead of username
                            AppCubit.get(context)
                                .storeLoginState(user: userData);
                            // setState(() {});
                            if (AppCubit.get(context).canCheckBiometrics) {
                              if (!(await AppCubit.get(context)
                                  .checkIsAuthonticated(userData.userName))) {
                                showFingerprintDialog(context,
                                    userData: userData, checker: checker);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.pushReplacementNamed(
                                      context, "/basicScreen",
                                      arguments: users[checker]);
                                });
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pushReplacementNamed(
                                    context, "/basicScreen",
                                    arguments: users[checker]);
                              });
                            }
                            ;
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        TranslationWidget().translations[
                            AppCubit.get(context).lang]!["login"]!,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text(
                TranslationWidget().translations[AppCubit.get(context).lang]![
                    "or_connecting_with"]!,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 47,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff375A8B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 7, left: 7),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FaIcon(
                                FontAwesomeIcons.facebookF,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 150,
                    height: 47,
                    child: ElevatedButton(
                      onPressed: () {
                        // the google button login....
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF14436),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 7, left: 7),
                            child: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Google",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(TranslationWidget().translations[
                  AppCubit.get(context).lang]!["don't_have_an_account"]!),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: Text(
                  TranslationWidget()
                      .translations[AppCubit.get(context).lang]!["sign_up"]!,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void showFingerprintDialog(BuildContext context,
      {required UsersAccount userData, required checker}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text(
              'Would you like to use fingerprint for easy login next time?'),
          actions: [
            TextButton(
              onPressed: () async {
                // Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushReplacementNamed(context, "/basicScreen",
                      arguments: users[checker]);
                });
                // await Future.delayed(const Duration(seconds: 2));
                // Navigator.of(context).pop();
                // Navigator.pushReplacementNamed(context, "/basicScreen",
                //     arguments: users[checker]);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                AppCubit.get(context).saveToLocalAuth(
                    userName: userData.userName, password: userData.passWord);
              },
              child: Text('Use Fingerprint'),
            ),
          ],
        );
      },
    );
  }
}
