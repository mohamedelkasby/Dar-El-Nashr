import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class TheDrawer extends StatefulWidget {
  const TheDrawer({super.key});

  @override
  State<TheDrawer> createState() => _TheDrawerState();
}

class _TheDrawerState extends State<TheDrawer> {
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // var padding = MediaQuery.of(context).padding;
    // double newHeight = height - padding.top - padding.bottom;

    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 5,
                ),
                // Image.asset(
                //   "assets/img/logo.png",
                //   height: 42,
                // ),
                Expanded(
                  child: ListTile(
                    title: Container(
                      color: AppCubit.get(context).themeMode == ThemeMode.light
                          ? primaryColor
                          : secondryColorDark,
                      child: Padding(
                        padding: const EdgeInsets.all(4.5),
                        child: Text(
                          "Newsletter",
                          style: TextStyle(
                            fontSize: 21,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: ClipRRect(
                    child: Container(
                      // color: const Color.fromARGB(255, 242, 215, 215),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            color: AppCubit.get(context).themeMode == ThemeMode.light
                ? primaryColor
                : goldColor,
          ),
          Expanded(
            child: Container(
              // height: newHeight,
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.only(
                      //     left: MediaQuery.of(context).size.width * .1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.home),
                            title: Text(TranslationWidget().translations[
                                AppCubit.get(context).lang]!["home_bar"]!),
                            onTap: () {
                              final currentPage =
                                  ModalRoute.of(context)?.settings.name;

                              if (currentPage == "/basicScreen") {
                                Navigator.pop(context);
                                AppCubit.get(context).scrollToTop();
                                // print("$currentPage  //the home");
                              } else {
                                // print("$currentPage //the nunhome");

                                Navigator.pop(context);
                                Navigator.pop(context);
                                AppCubit.get(context).scrollToTop();
                              }
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.account_circle),
                            title: Text(TranslationWidget().translations[
                                AppCubit.get(context).lang]!["profile_bar"]!),
                            onTap: () {
                              // Update the state of the app
                              // ...
                              // Then close the drawer
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Stack(
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                ),
                                if (AppCubit.get(context).itemsInCart > 0) ...[
                                  Positioned(
                                    top: -4,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(3.5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        AppCubit.get(context)
                                            .itemsInCart
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            title: Text(TranslationWidget().translations[
                                AppCubit.get(context).lang]!["cart_bar"]!),
                            onTap: () {
                              // Update the state of the app
                              // ...
                              // Then close the drawer
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.translate,
                            ),
                            title: Text(TranslationWidget().translations[
                                AppCubit.get(context).lang]!["translate"]!),
                            onTap: () {
                              Navigator.of(context).pop();
                              AppCubit.get(context).changeLang();
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.logout,
                            ),
                            title: Text(TranslationWidget().translations[
                                AppCubit.get(context).lang]!["sign_out"]!),
                            onTap: () {
                              Navigator.of(context).pop();
                              AppCubit.get(context).logout();
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    endIndent: 15,
                    indent: 5,
                    thickness: 2,
                  ),
                  IconButton(
                    icon: Icon(
                        context.watch<AppCubit>().themeMode == ThemeMode.light
                            ? Icons.dark_mode
                            : Icons.light_mode),
                    onPressed: () {
                      AppCubit.get(context).changeTheme();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
