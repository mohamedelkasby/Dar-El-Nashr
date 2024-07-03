import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //////////////////// Hero Crausal Section Start /////////////////

            const HeroCrausalList(),

            //////////////////// New Releases Section Start /////////////////

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerStyle("new releases"),
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    color:
                        ///////don't understand it pal wageh :) hhhh////
                        /// tha watch thing !!!!  ///
                        context.watch<AppCubit>().themeMode == ThemeMode.light
                            ? backgroundColor
                            : secondryColorDark,
                    height: MediaQuery.of(context).size.width * 1.02,
                    alignment: Alignment.center,
                    child: NewsReleasesList(),
                  ),
                  //////////////////// New Releases Section End /////////////////
                  divederConst(),
                  //////////////////// Featured Authors Section Start /////////////////
                  headerStyle(
                    TranslationWidget().translations[
                        AppCubit.get(context).lang]!["author_title"]!,
                  ),
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    color: AppCubit.get(context).themeMode == ThemeMode.light
                        ? backgroundColor
                        : secondryColorDark,
                    height: MediaQuery.of(context).size.width * .658,
                    alignment: Alignment.center,
                    child: FeaturedAuthorsList(),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color:
                                  primaryColor // This would be the width of the underline
                              ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthorsNamesPage(),
                            ),
                          );
                        },
                        child: Text(
                          "View all authors",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  //////////////////// Featured Authors Section end /////////////////

                  divederConst(),
                  headerStyle("dar el_nashr reader"),

                  //////////////////// Blog Section Start /////////////////

                  Column(
                    children: List<Widget>.generate(
                      blogData.length, //<============== length of the list
                      (int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .9,
                              width: double.infinity,
                              child: Image.asset(
                                blogData[index].img,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                blogData[index].title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Text(
                                blogData[index].description,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color:
                                  primaryColor // This would be the width of the underline
                              ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Read more on the dar el_nashr reader",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  //////////////////// Blog Section end /////////////////
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 50),
              color: AppCubit.get(context).themeMode == ThemeMode.light
                  ? backgroundColor
                  : secondryColorDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "the Tiiiiitle",
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Image.asset(
                        "assets/img/books/OIP.jpeg",
                        width: 180,
                      ),
                    ),
                  ),
                  const Text(
                      "MIT Sloan Management Review and the MIT Press have joined forces to explore the digital frontiers of management. Books in the “Management on the Cutting Edge” series present original research from leading lights in academia and industry, providing practical advice to business leaders on how to prepare for the exciting — and challenging — future that awaits us. Series editor: Abbie Lundberg\n\nNew in the series, From Intention to Impact shows what organizations, leaders, and people at all levels must do to create more inclusive environments that honor and value diversity. Malia C. Lazu shares a seven-stage guide through this process as well as a 3L model of listening, learning, and loving that readers can use from the initial excitement of doing “something” to the frustration when the inevitable pushback comes, and finally to the determination to do the hard work despite the challenges—on corporate and political fronts."),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        icon: const Icon(Icons.navigate_before),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppCubit.get(context).themeMode ==
                                        ThemeMode.light
                                    ? white
                                    : backgroundColorDark),
                            shape:
                                const MaterialStatePropertyAll(LinearBorder())),
                        onPressed: () {},
                        label: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Start reading now",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //////////////////////////////////////////////////////
                  SizedBox(
                    height: 270,
                    child: BookCrausal(),
                  ),
                  //////////////////////////////////////////////////////
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerStyle("Latest News"),
                  Image.asset("assets/img/MothersDay24.png"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "A Mother’s Day reading list for 2024",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Text(
                    "A collection of modern Mother’s Day reads.",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color:
                                  primaryColor // This would be the width of the underline
                              ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Read our blog",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  headerStyle("instgram"),
                  SizedBox(
                    height: 350,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      crossAxisCount: 2,
                      // childAspectRatio: 1,

                      children: [
                        Image.asset(
                          "assets/img/MothersDay24.png",
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/img/MothersDay24.png",
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/img/MothersDay24.png",
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/img/MothersDay24.png",
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shadowColor: null,
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3),
                                  bottomLeft: Radius.circular(3),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Load More",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.insights_rounded,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            shadowColor: null,
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3),
                                  bottomLeft: Radius.circular(3),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          label: const Text(
                            "Follow On Instgram",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 60,
                color: AppCubit.get(context).themeMode == ThemeMode.light
                    ? white
                    : secondryColorDark),
            Container(
              // margin: EdgeInsets.only(top: 20),
              color: AppCubit.get(context).themeMode == ThemeMode.light
                  ? primaryColor
                  : backgroundColorDark,
              height: 100,
              width: double.maxFinite,
              child: Image.asset(
                AppCubit.get(context).themeMode == ThemeMode.light
                    ? "assets/img/logo.png"
                    : "assets/img/logoDark.png",
              ),
            )
          ],
        ),
      ),
    );
  }
}
