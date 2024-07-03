import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class AuthorsNamesPage extends StatelessWidget {
  const AuthorsNamesPage({super.key});

  List<String> getAuthorsName() {
    List<String> names = [];
    for (int i = 0; i < authorsData.length; i++) {
      names.add(authorsData[i].name);
    }
    //// remove the dublicate . ///////

    names = [
      ...{...names}
    ];

    return names;
  }

  @override
  Widget build(BuildContext context) {
    List<String> authorsNames = getAuthorsName();
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: headerStyle("Our Authors"),
              ),
              Container(
                color: AppCubit.get(context).themeMode == ThemeMode.light
                    ? backgroundColor
                    : secondryColorDark,
                child: Column(
                  children: List.generate(
                    authorsNames.length,
                    (index) {
                      return Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 15),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                authorsNames[index].capitalizeByWord(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
