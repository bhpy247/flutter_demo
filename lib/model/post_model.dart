class PostsModel {
  int userId = 0;
  int id = 0;
  String title = "";
  String body = "";

  PostsModel({this.userId = 0, this.id = 0, this.title = "", this.body = ""});

  PostsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 0;
    id = json['id']?? 0;
    title = json['title']?? 0;
    body = json['body']?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
