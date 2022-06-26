class Favorilerim {
  final int id;
  final String yemekAdi;
  final String yemekURL;
  final String tarifURL;
  const Favorilerim({
    required this.id,
    required this.yemekAdi,
    required this.yemekURL,
    required this.tarifURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'yemekAdi': yemekAdi,
      'yemekURL': yemekURL,
      'tarifURL': tarifURL,
    };
  }

  Favorilerim.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        yemekAdi = res["yemekAdi"],
        yemekURL = res["yemekURL"],
        tarifURL = res["tarifURL"];
}
