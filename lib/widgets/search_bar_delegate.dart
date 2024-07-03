import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  SearchBarDelegate({
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final List<String> categories = ['All'] + AppCubit.get(context).category;

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Container(
          color: AppCubit.get(context).themeMode == ThemeMode.light
              ? white
              : backgroundColorDark,
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            color: AppCubit.get(context).themeMode == ThemeMode.light
                ? backgroundColor
                : secondryColorDark,
            child: Row(
              children: [
                Container(
                  // color: goldColor,
                  child: DropdownButton<String>(
                    alignment: Alignment.center,
                    underline: SizedBox(),
                    value: AppCubit.get(context).selectedCategory,
                    items: categories
                        .map((category) => DropdownMenuItem(
                              child: Text(category),
                              value: category,
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        //change the filter by category text
                        AppCubit.get(context).changeSelectedCategory(value);
                        //change the resualt of search with the change of filter
                        onSearchChanged(searchController.text);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) => onSearchChanged(value),
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          searchController.clear();
                          onSearchChanged("");
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
