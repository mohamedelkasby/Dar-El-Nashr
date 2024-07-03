import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

Widget hostBottomNavBar(context, {index}) {
  return BottomNavigationBar(
    fixedColor: primaryColor,
    unselectedItemColor: Colors.grey,
    items: [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: TranslationWidget()
              .translations[AppCubit.get(context).lang]!["home_bar"]!,
          tooltip: TranslationWidget()
              .translations[AppCubit.get(context).lang]!["home_bar"]!),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: TranslationWidget()
              .translations[AppCubit.get(context).lang]!["profile_bar"]!,
          tooltip: TranslationWidget()
              .translations[AppCubit.get(context).lang]!["profile_bar"]!),
      BottomNavigationBarItem(
        icon: Stack(
          children: [
            const Icon(
              Icons.shopping_cart,
            ),
            if (AppCubit.get(context).itemsInCart > 0) ...[
              Positioned(
                top: -5,
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
        label: TranslationWidget()
            .translations[AppCubit.get(context).lang]!["cart_bar"]!,
        tooltip: TranslationWidget()
            .translations[AppCubit.get(context).lang]!["cart_bar"]!,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.category,
        ),
        label: TranslationWidget()
            .translations[AppCubit.get(context).lang]!["category_bar"]!,
        tooltip: TranslationWidget()
            .translations[AppCubit.get(context).lang]!["category_bar"]!,
      ),
    ],
    currentIndex: selectedIndex,
    onTap: (value) {
      if (index == null) {
        Navigator.of(context).pop();
        selectedIndex = AppCubit.get(context).onItemTapped(value, 0);
      } else {
        selectedIndex = AppCubit.get(context).onItemTapped(value, index);
      }
      AppCubit.get(context).filteredItems = [];
    },
  );
}
