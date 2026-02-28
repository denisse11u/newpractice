import 'package:aplicacionflutter/sss/domain/datasources/movies_datasources.dart';
import 'package:aplicacionflutter/sss/infrastructure/mappers/movie_mapper.dart';
import 'package:aplicacionflutter/sss/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:aplicacionflutter/sss/config/constants/environments.dart';
import 'package:aplicacionflutter/sss/domain/entities/movies.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environments.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }
}
