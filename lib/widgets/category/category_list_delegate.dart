import 'package:dar_nashr_gameat_el_malek_soad/Screens/book/books_by_category.dart';
import 'package:dar_nashr_gameat_el_malek_soad/cubits/cubit.dart';
import 'package:dar_nashr_gameat_el_malek_soad/cubits/states.dart';
import 'package:dar_nashr_gameat_el_malek_soad/extensions/standards.dart';
import 'package:dar_nashr_gameat_el_malek_soad/widgets/category/category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListDelegate extends SliverPersistentHeaderDelegate {
  CategoryListDelegate({context});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsetsDirectional.all(5),
          color: AppCubit.get(context).themeMode == ThemeMode.light
              ? white
              : backgroundColorDark,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppCubit.get(context).category.length,
            itemBuilder: (context, index) {
              return CategoryButton(
                categoryName: AppCubit.get(context).category[index],
                onPress: () {
                  // pages[1];
                  // context.read<AppCubit>();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryTypeBody(
                        categoryName: AppCubit.get(context).category[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 40;

  @override
  // TODO: implement minExtent
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
