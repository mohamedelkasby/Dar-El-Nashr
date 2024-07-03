import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

Widget booksListView(context, {required List<BookModel> booksDisplayedList}) {
  return ListView.builder(
    itemCount: booksDisplayedList.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Container(
            color: AppCubit.get(context).themeMode == ThemeMode.light
                ? backgroundColor
                : secondryColorDark,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                BookPage(bookData: booksDisplayedList[index]),
                          ));
                        },
                        child: Image.asset(
                          booksDisplayedList[index].img,
                          width: MediaQuery.of(context).size.width * .32,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              booksDisplayedList[index].name.capitalizeByWord(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                booksDisplayedList[index].description,
                                style: TextStyle(fontSize: 15),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                              child: Text(
                                booksDisplayedList[index].authorName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 23, color: Colors.grey),
                              ),
                            ),
                            Text(
                              "${booksDisplayedList[index].price} \$",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          index != booksDisplayedList.length - 1
              ? Divider(
                  color: primaryColor,
                  indent: 30,
                  endIndent: 30,
                )
              : SizedBox()
        ],
      );
    },
  );
}
