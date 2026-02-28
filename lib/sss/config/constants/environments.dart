import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'NO HAY APIKEY';
}
