import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class MovieDetailsDao {
  static final MovieDetailsDao _singleton = MovieDetailsDao._internal();
  factory MovieDetailsDao() {
    return _singleton;
  }
  MovieDetailsDao._internal();


   //save and get single movie by id
  void saveSingleMovie(DataVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  DataVO? getSingleMovie(int movieId) {
    return getMovieBox().get(movieId);
  }

  Stream<DataVO?> getSingleMovieStream(int movieId) {
    return getMovieBox()
        .watch()
        .map((event) => getSingleMovie(movieId))
        .startWith(getSingleMovie(movieId));
  }

  Box<DataVO> getMovieBox() {
    return Hive.box<DataVO>(boxNameMovieDetailsVO);
  }
}
