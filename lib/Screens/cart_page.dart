import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';
import 'package:dar_nashr_gameat_el_malek_soad/modules/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // BookModel getBookDataByName(String bookName) {
  //   BookModel book;
  //   for (var element in allBooksData) {
  //     if (bookName == element.name) {
  //       book = element;
  //       return book;
  //     }
  //   }
  //   return allBooksData[0]; ////////////<=============== it's wrong
  // }

  @override
  Widget build(BuildContext context) {
    List<CartModel> element = AppCubit.get(context).cartList;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: AppCubit.get(context).themeMode == ThemeMode.light
            ? primaryColor
            : secondryColorDark,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: white, fontSize: 35),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: element.length == 0
            ? Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 1.5,
                    height: 10,
                    color:
                        context.watch<AppCubit>().themeMode == ThemeMode.light
                            ? primaryColor
                            : goldColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .29),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment
                      //     .center, ////<============ not working cuase of the upper column ..... what is the solve ask eng wageh

                      children: [
                        Text(
                          "The Cart Is Empty",
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          "Try Buy Some Elements",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: element.length,
                      itemBuilder: (context, index) {
                        // AppCubit.get(context).TotalPrice =
                        //     (element[index].count) * (element[index].bookPrice);
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Card(
                                  color: context.watch<AppCubit>().themeMode ==
                                          ThemeMode.light
                                      ? null
                                      : secondryColorDark,
                                  // semanticContainer: true,
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.asset(
                                            element[index].bookImg,
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround, //<==========not Working !!!
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ), //<==========remove it
                                            Row(
                                              children: [
                                                /////for space!?!?????!?!?!?!?!?
                                                const Expanded(
                                                    child: SizedBox()),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      element[index].bookName,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    Text(
                                                      element[index]
                                                          .bookCategory,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "${element[index].bookPrice}\$",
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange),
                                                    )
                                                  ],
                                                ),
                                                /////for space!?!?????!?!?!?!?!?
                                                const Expanded(
                                                    child: SizedBox()),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        element[index]
                                                            .count = AppCubit
                                                                .get(context)
                                                            .decrement(
                                                                element[index]
                                                                    .count,
                                                                index);
                                                      },
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: Colors.red[700],
                                                        size: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                        "${element[index].count}"),
                                                    IconButton(
                                                      onPressed: () {
                                                        element[index]
                                                            .count = AppCubit
                                                                .get(context)
                                                            .increment(
                                                                element[index]
                                                                    .count,
                                                                index);
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color:
                                                            Colors.green[700],
                                                        size: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ), //<==========remove it

                                            Text(
                                              "T.Price  ${(element[index].totalPrice)} \$",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.orange[600]),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        AppCubit.get(context).removeFromCart(
                                            name: element[index].bookName);
                                        AppCubit.get(context).cartItemsCount();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 20,
                                      )),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub Total",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      Text(
                        "${context.watch<AppCubit>().getFullPrice()} \$",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => primaryColor),
                      shape: const MaterialStatePropertyAll(
                        LinearBorder(),
                      ),
                      padding:
                          MaterialStatePropertyAll(EdgeInsets.only(left: 2)),
                      // minimumSize: MaterialStatePropertyAll(Size(0, 0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   width: double.maxFinite,
                        //   child: Text("buy"),
                        // ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(50)),
                          child: Container(
                            color: white,
                            height: MediaQuery.of(context).size.height * .048,
                            width: MediaQuery.of(context).size.width * .5,
                            child: Center(
                              child: Text(
                                "${AppCubit.get(context).getFullPrice()} \$",
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * .09),
                          child: Text(
                            "purch now",
                            style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "TAX Price",
                  //       style: TextStyle(fontSize: 25),
                  //     ),
                  //     Text("Price \$")
                  //   ],
                  // ),
                ],
              ),
      ),
    );
  }
}
