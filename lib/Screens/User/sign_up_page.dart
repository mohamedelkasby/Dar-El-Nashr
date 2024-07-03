import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _configPasswordKey = GlobalKey<FormFieldState>();
  bool hidePass = true;
  bool hidePass2 = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? mailError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        // backgroundColor: Color(0xff0aeba5),
                        color:
                            AppCubit.get(context).themeMode == ThemeMode.light
                                ? black
                                : white,
                      ),
                    ),
                  ),
                ),
                Text(
                  ' Page',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                  ),
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
                  TextFormField(
                    key: _userNameKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["please_enter_your_name"]!;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _userNameKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      enabledBorder: UnderlineInputBorder(
                          // borderRadius: BorderRadius.circular(5),
                          ),
                      labelText: TranslationWidget().translations[
                          AppCubit.get(context).lang]!["user_name"]!,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: _emailKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["please_enter_your_e-mail"]!;
                      } else if (!RegExp(
                              r"[a-zA-Z0-9.!#$%&\'*+-/=?^_`{|}~]+@[a-z]+\.(com|net)$")
                          .hasMatch(value)) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["Please_enter_a_valid_email"]!;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _emailKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      enabledBorder: const UnderlineInputBorder(
                          // borderRadius: BorderRadius.circular(5),
                          ),
                      labelText: TranslationWidget()
                          .translations[AppCubit.get(context).lang]!["E-Mail"]!,
                      errorText: mailError,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: _phoneKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["please_enter_your_phone_number"]!;
                      }
                      if (!RegExp(r'^(010|011|012|015)[0-9]{8}$')
                          .hasMatch(value)) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["Please_enter_a_valid_phone_number"]!;
                      }
                      // else if (value.length != 11) {
                      //   return "the phone number must be 11 numbers";
                      // }
                      else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _phoneKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      enabledBorder: UnderlineInputBorder(
                          // borderRadius: BorderRadius.circular(5),
                          ),
                      labelText: TranslationWidget().translations[
                          AppCubit.get(context).lang]!["phone_number"]!,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: _passwordKey,
                    controller: _passwordController,
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
                      _passwordKey.currentState!.validate();
                    },
                    obscureText: hidePass,
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
                      disabledBorder: const OutlineInputBorder(),
                      labelText: TranslationWidget().translations[
                          AppCubit.get(context).lang]!["password"]!,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: _configPasswordKey,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["please_confirm_your_password"]!;
                      } else if (value != _passwordController.text) {
                        return TranslationWidget().translations[
                            AppCubit.get(context)
                                .lang]!["Passwords_do_not_match"]!;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _configPasswordKey.currentState!.validate();
                    },
                    obscureText: hidePass2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.key_outlined),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePass2 = !hidePass2;
                            });
                          },
                          icon: Icon(hidePass2
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      enabledBorder: const UnderlineInputBorder(
                          // borderRadius: BorderRadius.circular(5),
                          ),
                      disabledBorder: const OutlineInputBorder(),
                      labelText: TranslationWidget().translations[
                          AppCubit.get(context).lang]!["confirm_password"]!,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          var email = _emailKey.currentState!.value;
                          int accountCheck = 0;
                          for (var element in users) {
                            if (element.eMail == email) {
                              accountCheck = 1;
                              break;
                            }
                          }
                          if (accountCheck == 0) {
                            mailError = null;
                            setState(() {});

                            //////  add a new account to the users list ... it is not permanent  ////
                            UsersAccount newAccount = UsersAccount(
                                userName: _userNameKey.currentState!.value,
                                eMail: _emailKey.currentState!.value,
                                phoneNumber:
                                    double.parse(_phoneKey.currentState!.value),
                                passWord: _passwordKey.currentState!.value);
                            users.add(newAccount);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          } else if (accountCheck == 1) {
                            mailError = TranslationWidget().translations[
                                AppCubit.get(context)
                                    .lang]!["The_Account_is_already_used"]!;
                            setState(() {});
                          }
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text("processing Data"),
                          //   ),
                          // );
                          // Future.delayed(const Duration(seconds: 1), () {
                          //   Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //       builder: (context) => const LoginScreen(),
                          //     ),
                          //   );
                          // });
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
                            AppCubit.get(context).lang]!["create"]!,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(TranslationWidget().translations[
                  AppCubit.get(context).lang]!["already_have_an_account"]!),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  TranslationWidget()
                      .translations[AppCubit.get(context).lang]!["login"]!,
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
}
