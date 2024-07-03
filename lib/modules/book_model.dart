class BookModel {
  final String name;
  final String img;
  final double price;
  final String category;
  final String authorName;
  final String description;
  // bool bought;

  BookModel({
    required this.name,
    required this.img,
    required this.price,
    required this.category,
    required this.authorName,
    required this.description,
    // this.bought = false,
  });
}

BookModel book1 = BookModel(
  name: "look at me",
  img: "assets/img/books/LAM.jpeg",
  price: 2.30,
  authorName: "don norman",
  category: "geographic",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);
BookModel book2 = BookModel(
  name: "david kid",
  img: "assets/img/books/OIP.jpeg",
  price: 4.99,
  category: "historical",
  authorName: "don norman",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);
BookModel book3 = BookModel(
  name: "look at him",
  img: "assets/img/books/LAM.jpeg",
  price: 2.35,
  category: "strategic",
  authorName: "anonymous author",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);
BookModel book4 = BookModel(
  name: "david not kid",
  img: "assets/img/books/OIP.jpeg",
  price: 7.00,
  category: "cultural",
  authorName: "anonymous author",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);
BookModel book5 = BookModel(
  name: "david not kid 2",
  img: "assets/img/books/OIP.jpeg",
  price: 7.00,
  category: "cultural",
  authorName: "anonymous author",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);
BookModel book6 = BookModel(
  name: "david not kid 3",
  img: "assets/img/books/OIP.jpeg",
  price: 7.00,
  category: "cultural",
  authorName: "anonymous author",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);
BookModel book7 = BookModel(
  name: "david not kid 4",
  img: "assets/img/books/OIP.jpeg",
  price: 7.00,
  category: "cultural",
  authorName: "anonymous author",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);
BookModel book8 = BookModel(
  name: "david not kid 5",
  img: "assets/img/books/OIP.jpeg",
  price: 7.00,
  category: "cultural",
  authorName: "anonymous author",
  description:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
);

List<BookModel> allBooksData = [
  book1,
  book2,
  book3,
  book4,
  book5,
  book6,
  book7,
  book8,
];
