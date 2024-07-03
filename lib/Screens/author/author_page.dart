import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class AuthorPage extends StatelessWidget {
  final String authorName;
  const AuthorPage({super.key, required this.authorName});

  ///to gather all the books of the same author
  List<BookModel> booksByAuthor(String authorName) {
    List<BookModel> authorBooks = [];

    for (var i = 0; i < allBooksData.length; i++) {
      if (authorName == allBooksData[i].authorName) {
        authorBooks.add(allBooksData[i]);
      }
    }
    return authorBooks;
  }

  AuthorsModel getAuthorData(String authorName) {
    AuthorsModel author = AuthorsModel(img: "", name: "", desc: "");
    for (var i = 0; i < authorsData.length; i++) {
      if (authorName == authorsData[i].name) {
        return author = authorsData[i];
      }
    }
    return author;
  }

  @override
  Widget build(BuildContext context) {
    final author = getAuthorData(authorName);
    final _buttonCarouselController = CarouselController();
    List<BookModel> books = booksByAuthor(authorName);
    int booksLength = (books.length / 2).round();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  color: AppCubit.get(context).themeMode == ThemeMode.light
                      ? backgroundColor
                      : secondryColorDark,
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(35)),
                              child: Container(
                                width: 210,
                                height: 210,
                                color: primaryColor,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(35)),
                              child: Container(
                                width: 205,
                                height: 205,
                                color: AppCubit.get(context).themeMode ==
                                        ThemeMode.light
                                    ? backgroundColor
                                    : secondryColorDark,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(35)),
                              child: Image.asset(
                                author.img.isNotEmpty
                                    ? author.img
                                    : "assets/img/no-image.jpg",
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                                color: Colors.grey,
                                colorBlendMode: BlendMode.saturation,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          textAlign: TextAlign.center,
                          author.name.isNotEmpty
                              ? author.name.capitalizeByWord()
                              : "there is no author".capitalizeByWord(),
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        author.desc.isNotEmpty
                            ? author.desc.capitalize()
                            : "there is no author descriotion"
                                .capitalizeByWord(),
                        style: const TextStyle(
                          fontSize: 15,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        // maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: author.name.isNotEmpty
                    ? headerStyle("Books by the Author")
                    : headerStyle("Books that have no author", headerFont: 30),
              ),
            ),
            ////////////////////////// Books By Author ////////////////////////////////
            books.isNotEmpty
                ? Container(
                    color: AppCubit.get(context).themeMode == ThemeMode.light
                        ? backgroundColor
                        : secondryColorDark,
                    height: 350,
                    child: Stack(
                      children: [
                        CarouselSlider.builder(
                          carouselController: _buttonCarouselController,
                          itemCount: booksLength,
                          options: CarouselOptions(
                            enableInfiniteScroll:
                                booksLength > 1 ? true : false,
                            height: double.maxFinite,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 6),
                            autoPlayAnimationDuration:
                                const Duration(seconds: 2),
                            enlargeCenterPage: false,
                            viewportFraction: 1,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final int first = index * 2;
                            final int second = first + 1;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [first, second].map((index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            BookPage(bookData: books[index]),
                                      ));
                                    },
                                    child: Image.asset(
                                      books[index].img,
                                      width: MediaQuery.of(context).size.width *
                                          .41,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        //<====================== Previous Button ==========================>

                        booksLength > 1
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          _buttonCarouselController
                                              .previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 800),
                                                  curve: Curves.linear);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .122,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .11,
                                          color: AppCubit.get(context)
                                                      .themeMode ==
                                                  ThemeMode.light
                                              ? backgroundColor.withOpacity(.75)
                                              : secondryColorDark
                                                  .withOpacity(.75),
                                          child: Icon(
                                            Icons.navigate_before,
                                            color: primaryColor,
                                            size: 45,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ), //<====================== Next Button ==========================>
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          _buttonCarouselController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 800),
                                              curve: Curves.linear);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .122,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .11,
                                          color: AppCubit.get(context)
                                                      .themeMode ==
                                                  ThemeMode.light
                                              ? backgroundColor.withOpacity(.75)
                                              : secondryColorDark
                                                  .withOpacity(.75),
                                          child: Icon(
                                            Icons.navigate_next,
                                            color: primaryColor,
                                            size: 45,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: RichText(
                      text: TextSpan(
                          text: "There Is ",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? black
                                  : white),
                          children: [
                            TextSpan(
                              text: "No Books",
                              style: TextStyle(
                                  backgroundColor: primaryColor, color: white),
                            ),
                            const TextSpan(text: " For This Author"),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
