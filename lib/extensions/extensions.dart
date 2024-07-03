extension Capitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension CapitalizeByWord on String {
  String capitalizeByWord() {
    // if (trim().isEmpty) {
    //   return '';
    // }
    return split(' ')
        .map((element) =>
            "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
        .join(" ");
  }
}
