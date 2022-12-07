import 'dart:convert';

import 'package:flutter_demo/model/post_model.dart';
import 'package:http/http.dart';

class HomeController {
  
  Future<Response> getApiData(String apiEndpoint) async {
    try{
      Response response;
      Map<String,String> header = {"Accept":"*/*","Connection": "keep-alive"};
      Uri uri = Uri.parse(apiEndpoint,);
        print(uri);
       response = await get(uri, headers:header);
      if(response.statusCode == 401){
       response = Response("Error in response", 401);
        print("Error in api ${response.body}");
      } 
      return response;
    } catch (e,s){
      print("Error in getData: $e");
      print(s);
      return Response("Error While loading the data", 400);
    }
  }
  
  Future<List<PostsModel>> getPostsData() async {
    List<PostsModel> postModels = [];
    try {
      Response response = await getApiData("https://jsonplaceholder.typicode.com/posts");
      List<Map<String,dynamic>> data = List.castFrom(jsonDecode(response.body));
      data.forEach((element) {
        postModels.add(PostsModel.fromJson(element));
      });
    }
    catch (e,s){
      print("Error in getPostsData: $e");
      print(s);
      postModels = [];
    }
    return postModels;
  }

}