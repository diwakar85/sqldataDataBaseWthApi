import 'dart:convert';
import 'package:apiandsql/modelClass/apiModel.dart';
import 'package:http/http.dart' as http;

import '../helper/dbHelper.dart';

class HttpRequest {
  Future<List<Post>> fetchAllData() async {
    //Fetch Data from API
    String API = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(Uri.parse(API));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Post> listPhotos = data.map((e) => Post.formJson(e)).toList();
      for (Post objPhoto in listPhotos) {
        await DBHelper.dbHelper.insert(objPhoto);
      }
    } else {
      throw Exception("no data Found");
    }

    //Fetch Data from Database
    List<Post> arrPosts = await DBHelper.dbHelper.fetchAllData();
    return arrPosts;
  }
}
