import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class NewsReleasesList extends StatefulWidget {
  NewsReleasesList({super.key});

  @override
  State<NewsReleasesList> createState() => _NewsReleasesListState();
}

class _NewsReleasesListState extends State<NewsReleasesList> {
  late final CarouselController buttonCarouselController;
  @override
  void initState() {
    buttonCarouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: buttonCarouselController,
          itemCount: (allBooksData.length / 2).round(),
          options: CarouselOptions(
            height: double.maxFinite,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayAnimationDuration: const Duration(seconds: 2),
            enlargeCenterPage: false,
            viewportFraction: 1,
          ),
          itemBuilder: (context, index, realIndex) {
            final int first = index * 2;
            final int second = first + 1;
            return Row(
              children: [first, second].map((index) {
                return Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BookPage(bookData: allBooksData[index]),
                            ));
                          },
                          child: Image.asset(
                            allBooksData[index].img,
                            width: MediaQuery.of(context).size.width * .5,
                          ),
                        ),
                        Text(
                          allBooksData[index].name.capitalizeByWord(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          allBooksData[index].authorName,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          "${allBooksData[index].price} \$",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        //<====================== Previous Button ==========================>
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                buttonCarouselController.previousPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linear);
              },
              child: Container(
                height: MediaQuery.of(context).size.width * .122,
                width: MediaQuery.of(context).size.width * .11,
                color: AppCubit.get(context).themeMode == ThemeMode.light
                    ? backgroundColor.withOpacity(.75)
                    : secondryColorDark.withOpacity(.75),
                child: Icon(
                  Icons.navigate_before,
                  color: AppCubit.get(context).themeMode == ThemeMode.light
                      ? primaryColor
                      : white,
                  size: 45,
                ),
              ),
            ),
          ),
        ),
        //<====================== Next Button ==========================>
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                buttonCarouselController.nextPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linear);
              },
              child: Container(
                height: MediaQuery.of(context).size.width * .122,
                width: MediaQuery.of(context).size.width * .11,
                color: AppCubit.get(context).themeMode == ThemeMode.light
                    ? backgroundColor.withOpacity(.75)
                    : secondryColorDark.withOpacity(.75),
                child: Icon(
                  Icons.navigate_next,
                  color: AppCubit.get(context).themeMode == ThemeMode.light
                      ? primaryColor
                      : white,
                  size: 45,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
