class Book   {
  final String category;
  final String name;
  final String auth;
  final String imageUrl;
  final String uelForDownload;
  final int pagesCount;
  final num rating;
  final num height;
  final num width;
  Book(
      {required this.rating,
        required this.height,
        required this.auth,
        required this.name,
        required this.category,
        required this.imageUrl,
        required this.uelForDownload,
        required this.pagesCount,
      required this.width
      });

}