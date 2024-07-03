class BlogModel {
  final String img;
  final String title;
  final String description;

  BlogModel({
    required this.img,
    required this.title,
    required this.description,
  });
}

BlogModel blog1 = BlogModel(
  img: "assets/img/blogs/anatomy-of-melancholy_lead.jpg",
  title: "title",
  description: "description",
);
BlogModel blog2 = BlogModel(
  img: "assets/img/blogs/Collapse-lead-image.jpg",
  title: "title",
  description: "description",
);
BlogModel blog3 = BlogModel(
  img: "assets/img/blogs/Dennett-and-Vat.jpg",
  title: "title",
  description: "description",
);
List<BlogModel> blogData = [
  blog1,
  blog2,
  blog3,
];
