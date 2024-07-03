import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class BasicScreen extends StatefulWidget {
  const BasicScreen({
    super.key,
  });

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

int selectedIndex = 0;

class _BasicScreenState extends State<BasicScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Extract the arguments passed using Navigator.pushNamed
    final UsersAccount userData =
        ModalRoute.of(context)!.settings.arguments as UsersAccount;
    final List<Widget> pages = AppCubit.get(context).filteredItems.isEmpty
        ? <Widget>[
            const HomePage(),
            ProfilePage(
              userData: userData,
            ),
            const CartPage(),
            const CategoryPage(),
          ]
        : <Widget>[
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
          ];
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            controller: context.watch<AppCubit>().scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  snap: true,
                  elevation: 10.0,
                  shadowColor: Colors.grey,
                  toolbarHeight: 60,
                  leadingWidth: 150,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        // widget.backIcon,
                        Expanded(
                          child: Image(
                            image: AppCubit.get(context).themeMode ==
                                    ThemeMode.light
                                ? const AssetImage("assets/img/logo.png")
                                : const AssetImage("assets/img/logoDark.png"),
                          ),
                        ),
                      ],
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
                                      AppCubit.get(context)
                                          .itemsInCart
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        );
                      },
                    ),
                  ],
                ),

                /////////////// Search Bar Start /////////////////
                selectedIndex == 1 || selectedIndex == 2
                    ? const SliverToBoxAdapter(
                        child: SizedBox(),
                      )
                    : SliverPersistentHeader(
                        pinned: true,
                        delegate: SearchBarDelegate(
                            searchController: searchController,
                            onSearchChanged:
                                AppCubit.get(context).filterSearch),
                      ),

                /////////////// Search Bar End /////////////////

                /////////////// Category list Start /////////////////
                selectedIndex == 1 || selectedIndex == 2
                    ? const SliverToBoxAdapter(
                        child: SizedBox(),
                      )
                    : SliverPersistentHeader(
                        delegate: CategoryListDelegate(context: context),
                        // floating: true,
                        pinned: true,
                      ),
                /////////////// Category list End /////////////////

                /////////////// the result of search start /////////////////
                AppCubit.get(context).filteredItems.isEmpty ||
                        (selectedIndex == 1 || selectedIndex == 2)
                    ? const SliverToBoxAdapter(
                        child: SizedBox(),
                      )
                    : SliverToBoxAdapter(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * .68,
                            child: booksListView(context,
                                booksDisplayedList:
                                    AppCubit.get(context).filteredItems)),
                      ),

                /////////////// the result of search End /////////////////
              ];
            },
            body: IndexedStack(
              index: selectedIndex,
              children: [
                pages[0],
                pages[1],
                pages[2],
                pages[3],
              ],
            ),
          ),
        ),
        //////////////////// Drawer Start /////////////////
        drawer: const TheDrawer(),
        //////////////////// Drawer End /////////////////

        ////////////// Floating Action Button Start ///////////

        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: selectedIndex == 2 ||
                selectedIndex == 1 ||
                AppCubit.get(context).lisitenToScroll()
            ? null
            : ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Container(
                  color: AppCubit.get(context).themeMode == ThemeMode.light
                      ? secondryColor
                      : primaryColor,
                  child: IconButton(
                    color: white,
                    onPressed: () => AppCubit.get(context).scrollToTop(),
                    icon: const Icon(
                      Icons.keyboard_arrow_up,
                      size: 35,
                    ),
                  ),
                ),
              ),

        ////////////// Floating Action Button End ///////////

        ////////////// Bottom Nabvigation Bar Start ///////////

        bottomNavigationBar: hostBottomNavBar(context, index: selectedIndex),

        ////////////// Bottom Nabvigation Bar End ///////////
      ),
    );
  }
}
