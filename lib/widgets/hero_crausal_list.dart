import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';
import 'package:dar_nashr_gameat_el_malek_soad/modules/hero_book_data_model.dart';

class HeroCrausalList extends StatefulWidget {
  const HeroCrausalList({super.key});

  @override
  State<HeroCrausalList> createState() => HeroCrausalListState();
}

class HeroCrausalListState extends State<HeroCrausalList> {
  final _controller = LoopPageController();
  double _currentPage = 0;
  final int _pageCount = heroBookData.length;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /////////////////// The Hero Book Scroll Start ///////////////////
        SizedBox(
          height: MediaQuery.of(context).size.width * 1.38,
          child: LoopPageView.builder(
            controller: _controller,
            itemCount: heroBookData.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 1.45,
                      color: heroBookData[index].groundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 45, 0, 160),
                        child: Image.asset(
                          heroBookData[index].img,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * .58,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      color:
                          context.watch<AppCubit>().themeMode == ThemeMode.light
                              ? backgroundColor.withOpacity(.8)
                              : backgroundColorDark.withOpacity(.7),
                      // AppCubit.get(context).themeMode == ThemeMode.light
                      //     ? backgroundColor.withOpacity(.8)
                      //     : backgroundColorDark.withOpacity(.7),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              heroBookData[index].textHead.capitalize(),
                              style: const TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              heroBookData[index].textDesc,
                              style: TextStyle(
                                fontSize: 23,
                                height:
                                    MediaQuery.of(context).size.height * .0014,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        /////////////////// The Hero Book Scroll End ///////////////////

        /////////////////// The Dots For Hero Section Start ///////////////////

        Positioned(
          top: MediaQuery.of(context).size.width * 1.32,
          left: 0.0,
          right: 0.0,
          child: Center(
            child: Stack(children: [
              DotsIndicator(
                dotsCount: _pageCount,
                position: _currentPage.toInt(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ]),
          ),
        ),
        /////////////////// The Dots For Hero Section End ///////////////////
      ],
    );
  }
}
