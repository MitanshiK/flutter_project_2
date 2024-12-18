class NewsModal{
  final String author;
  final String title;
  final String url;
  final String updatedAt;
  final int id;

  NewsModal({
    required this.author,
    required this.title,
    required this.url,
    required this.updatedAt,
    required this.id
  });

  factory NewsModal.fromJson(Map<String,dynamic> json){
    return NewsModal(
      author: json["author"] ?? "", 
      title: json["title"] ?? "",
       url:json["url"] ?? "",
        updatedAt: json["updated_at"]?? "",
         id: json["story_id"] ?? 0) ;
  }

}