import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/service/parseErrorLogger.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('posts')
  Future<List<PostModel>> getPosts();
}
