import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class BookPage extends StatefulWidget {
  final BookModel bookData;

  const BookPage({super.key, required this.bookData});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with TickerProviderStateMixin {
  bool hardEnabled = false;
  bool eEnabled = false;
  bool isDescriptionClicked = false;
  bool isAuthorClicked = false;
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late AnimationController _descriptionController;
  late AnimationController _authorController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Animation duration
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Animation duration
    );
    _descriptionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Animation duration
    );
    _authorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Animation duration
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    _descriptionController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  bool checkNameIsInCart() {
    for (var element in AppCubit.get(context).cartList) {
      if (element.bookName == widget.bookData.name) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    AppCubit fromCubit = AppCubit.get(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          // SizedBox(
          //   height: 50,
          // ),
          Wrap(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                color: fromCubit.themeMode == ThemeMode.light
                    ? backgroundColor
                    : secondryColorDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.bookData.img,
                      width: 250,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.bookData.name.capitalizeByWord(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.bookData.category.capitalize(),
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(fontSize: 26, color: Colors.grey),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "By ",
                          style: TextStyle(fontSize: 26, color: secondryColor),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5,
                                  color:
                                      secondryColor // This would be the width of the underline
                                  ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => AuthorPage(
                                  authorName: widget.bookData.authorName,
                                ),
                              ),
                            ),
                            child: Text(
                              widget.bookData.authorName.capitalizeByWord(),
                              style:
                                  TextStyle(fontSize: 26, color: secondryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ////////////////////

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: fromCubit.themeMode == ThemeMode.light
                            ? hardEnabled
                                ? enabledButtonColor
                                : disabledButtonColor
                            : hardEnabled
                                ? enabledButtonColorDark
                                : disabledButtonColorDark,
                        child: ListTile(
                          dense: true,
                          title: const Text(
                            "Hard Cover",
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: hardEnabled
                              ? const Icon(Icons.arrow_drop_down)
                              : const Icon(Icons.arrow_right),
                          selected: hardEnabled,
                          selectedColor: fromCubit.themeMode == ThemeMode.light
                              ? primaryColor
                              : const Color.fromARGB(255, 25, 152, 206),
                          onTap: () {
                            setState(() {
                              hardEnabled = !hardEnabled;
                              hardEnabled
                                  ? _animationController.forward()
                                  : _animationController.reverse();
                              if (hardEnabled == true) {
                                eEnabled = false;
                                _animationController2.reverse();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    SizeTransition(
                      axisAlignment: -1,
                      sizeFactor: _animationController,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 26),
                        width: double.maxFinite,
                        color: fromCubit.themeMode == ThemeMode.light
                            ? white
                            : backgroundColorDark,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${widget.bookData.price} \$",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                // onPressed: fromCubit.buttonEnabled
                                //     ? () => fromCubit.addCartItem()
                                //     : null,
                                onPressed:

                                    //////////// when press to add to  cart  //////////////

                                    !checkNameIsInCart()
                                        ? () {
                                            fromCubit.addToCart(
                                                bookData: widget.bookData);
                                            fromCubit.cartItemsCount();
                                          }
                                        : () {
                                            //////////// when press to remove from cart  //////////////

                                            fromCubit.removeFromCart(
                                                name: widget.bookData.name);
                                            fromCubit.cartItemsCount();
                                          },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        color: primaryColor), // Border color
                                  )),
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => primaryColor),
                                ),
                                child: Text(!checkNameIsInCart()
                                    ? "Add To Card"
                                    : "Remove From Card"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: fromCubit.themeMode == ThemeMode.light
                            ? eEnabled
                                ? enabledButtonColor
                                : disabledButtonColor
                            : hardEnabled
                                ? enabledButtonColorDark
                                : disabledButtonColorDark,
                        child: ListTile(
                          dense: true,
                          title: const Text(
                            "e Cover",
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: eEnabled
                              ? const Icon(Icons.arrow_drop_down)
                              : const Icon(Icons.arrow_right),
                          selected: eEnabled,
                          selectedColor: fromCubit.themeMode == ThemeMode.light
                              ? primaryColor
                              : const Color.fromARGB(255, 25, 152, 206),
                          onTap: () {
                            setState(() {
                              eEnabled = !eEnabled;
                              eEnabled
                                  ? _animationController2.forward()
                                  : _animationController2.reverse();
                              if (eEnabled == true) {
                                hardEnabled = false;
                                _animationController.reverse();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    SizeTransition(
                      sizeFactor: _animationController2,
                      axisAlignment: -1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 26),
                        width: double.maxFinite,
                        color: fromCubit.themeMode == ThemeMode.light
                            ? white
                            : backgroundColorDark,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${widget.bookData.price} \$",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "Description",
                        style: TextStyle(fontSize: 21),
                      ),
                      trailing: Icon(isDescriptionClicked
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right),
                      shape: Border(
                        bottom: BorderSide(
                          color: isDescriptionClicked
                              ? primaryColor
                              : Colors.black,
                        ),
                      ),
                      selected: isDescriptionClicked,
                      onTap: () {
                        setState(() {
                          isDescriptionClicked = !isDescriptionClicked;
                          isDescriptionClicked
                              ? _descriptionController.forward()
                              : _descriptionController.reverse();
                          if (isDescriptionClicked == true) {
                            _authorController.reverse();
                            isAuthorClicked = false;
                          }
                        });
                      },
                    ),
                    SizeTransition(
                      sizeFactor: _descriptionController,
                      axisAlignment: -1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(widget.bookData.description),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "Author(s)",
                        style: TextStyle(fontSize: 21),
                      ),
                      trailing: Icon(isAuthorClicked
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right),
                      shape: Border(
                        bottom: BorderSide(
                          color: isAuthorClicked ? primaryColor : Colors.black,
                        ),
                      ),
                      selected: isAuthorClicked,
                      onTap: () {
                        setState(() {
                          isAuthorClicked = !isAuthorClicked;
                          isAuthorClicked
                              ? _authorController.forward()
                              : _authorController.reverse();
                          if (isAuthorClicked == true) {
                            _descriptionController.reverse();
                            isDescriptionClicked = false;
                          }
                        });
                      },
                    ),
                    SizeTransition(
                      sizeFactor: _authorController,
                      axisAlignment: -1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(widget.bookData.authorName),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 60,
            color: fromCubit.themeMode == ThemeMode.light
                ? white
                : secondryColorDark,
          ),
          Container(
            // margin: EdgeInsets.only(top: 20),
            color: fromCubit.themeMode == ThemeMode.light
                ? primaryColor
                : backgroundColorDark,
            height: 100,
            width: double.maxFinite,
            child: Image.asset(fromCubit.themeMode == ThemeMode.light
                ? "assets/img/logo.png"
                : "assets/img/logoDark.png"),
          )
        ],
      ),
    );
  }
}
