import 'package:aplicacionflutter/sss/domain/datasources/movies_datasources.dart';
import 'package:aplicacionflutter/sss/domain/entities/movies.dart';
import 'package:aplicacionflutter/sss/domain/repositories/movies_repositories.dart';

class MovieRepositoryImpl extends MoviesRepositories {
  final MoviesDatasources datasources;
  MovieRepositoryImpl(this.datasources);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasources.getNowPlaying(page: page);
  }
}
