import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class CategoryTypeBody extends StatelessWidget {
  const CategoryTypeBody({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final List<BookModel> booksByCateg = [];

    for (BookModel element in allBooksData) {
      if (categoryName == element.category) {
        booksByCateg.add(element);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        shadowColor: Colors.grey,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: SizedBox(
          height: 40,
          child: Image(
            image: AppCubit.get(context).themeMode == ThemeMode.light
                ? const AssetImage("assets/img/logo.png")
                : const AssetImage("assets/img/logoDark.png"),
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.menu,
                      size: 35,
                    ),
                    if (AppCubit.get(context).itemsInCart > 0) ...[
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3.5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            AppCubit.get(context).itemsInCart.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
      ),
      body: booksListView(context, booksDisplayedList: booksByCateg),
      drawer: const TheDrawer(),
      bottomNavigationBar: hostBottomNavBar(
        context,
      ),
    );
  }
}
