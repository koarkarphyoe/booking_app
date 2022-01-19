import 'package:hive/hive.dart';
import 'package:student_app/data/vos/movie_details_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class MovieDetailsDao {
  static final MovieDetailsDao _singleton = MovieDetailsDao._internal();
  factory MovieDetailsDao() {
    return _singleton;
  }
  MovieDetailsDao._internal();

  void saveMovieDetails(MovieDetailsVO movieDetails) async {
    await getMovieDetailsBox().put(movieDetails.id, movieDetails);
  }

  MovieDetailsVO? getMovieDetails(int movieId) {
    return getMovieDetailsBox().get(movieId);
  }

  Box<MovieDetailsVO> getMovieDetailsBox() {
    return Hive.box<MovieDetailsVO>(boxNameMovieDetailsVO);
  }
}
