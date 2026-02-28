import 'package:aplicacionflutter/sss/domain/entities/movies.dart';

abstract class MoviesRepositories {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
