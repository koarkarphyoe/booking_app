import 'package:hive/hive.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/network/api_constants.dart';
import 'package:student_app/persistence/hive_constants.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  // save and get all movie to peristence
  void saveAllMovie(List<DataVO> movieList) async {
    // Map<int, DataVO> movieMap = {
    //   for (var movie in movieList) movie.id!.toInt(): movie
    // };
    Map<int, DataVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  List<DataVO> getAllMovie() {
    return getMovieBox().values.toList();
  }

  //save and get single movie by id
  void saveSingleMovie(DataVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  DataVO? getSingleMovie(int movieId) {
    return getMovieBox().get(movieId);
  }


  ///Reactive Programming 
  ///
  Stream<void> getAllMovieEventStream() {
    return getMovieBox().watch();
  }

  Box<DataVO> getMovieBox() {
    return Hive.box<DataVO>(boxNameDataVO);
  }
}
