class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final int like;
  final int comments;
  final int createdAt;
  final String id;

  VideoModel({
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.creatorUid,
    required this.like,
    required this.comments,
    required this.createdAt,
    required this.title,
    required this.id,
  });

  VideoModel.fromJson(Map<String, dynamic> json, String videoId)
    : description = json["description"],
      fileUrl = json["fileUrl"],
      thumbnailUrl = json["thumbnailUrl"],
      creatorUid = json["creatorUid"],
      like = json["like"],
      comments = json["comments"],
      createdAt = json["createdAt"],
      id = videoId,
      title = json["title"];

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "creatorUid": creatorUid,
      "like": like,
      "comments": comments,
      "createdAt": createdAt,
      "title": title,
      "id": id,
    };
  }
}
