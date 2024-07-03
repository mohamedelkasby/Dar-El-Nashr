import 'package:dar_nashr_gameat_el_malek_soad/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String categoryName;
  final Function onPress;

  const CategoryButton({
    super.key,
    required this.categoryName,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: TextButton(
        style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(130, 35)),
            padding: MaterialStatePropertyAll(EdgeInsetsDirectional.all(0)),
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 206, 206, 206)),
            shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
        onPressed: () => onPress(),
        child: Text(
          categoryName.capitalize(),
        ),
      ),
    );
  }
}
