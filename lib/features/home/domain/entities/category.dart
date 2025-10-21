/// Category entity for price list
class Category {
  final String id;
  final String name;
  final String pdfAssetPath; // Can be either URL or asset path

  const Category({
    required this.id,
    required this.name,
    required this.pdfAssetPath,
  });
}
