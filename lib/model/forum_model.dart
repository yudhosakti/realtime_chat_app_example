class ForumModel {
  final int idForum;
  final String judulForum;
  final String gambarForum;
  final String deskripsiForum;

  ForumModel(
      {required this.deskripsiForum,
      required this.gambarForum,
      required this.idForum,
      required this.judulForum});

  factory ForumModel.getDataFromJSON(Map<String, dynamic> json) {
    return ForumModel(
        deskripsiForum: json['deskripsi'] ?? '',
        gambarForum: json['image'] ?? '',
        idForum: json['id_forum'] ?? 0,
        judulForum: json['name'] ?? 0);
  }
}
