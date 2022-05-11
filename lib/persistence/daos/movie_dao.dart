import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_app/data/vos/data_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  // save and get all movie to peristence
  void saveAllMovie(List<DataVO> movieList,) async {
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

  //Reactive Programming
  Stream<List<DataVO>> getAllComingSoonMovieStream() {
    return getMovieBox().watch().map((event) {
      return getAllMovie()
          .where((element) => element.isComingSoonMovie ?? false)
          .toList();
    }).startWith(getAllMovie()
        .where((element) => element.isComingSoonMovie ?? false)
        .toList());
  }

  Stream<List<DataVO>> getAllCurrentMovieStream() {
    return getMovieBox()
        .watch()
        .map((event) =>
            getAllMovie().where((element) => element.isCurrentMovie!).toList())
        .startWith(getAllMovie()
            .where((element) => element.isCurrentMovie ?? false)
            .toList());
  }

  //Create Hive Box
  Box<DataVO> getMovieBox() {
    return Hive.box<DataVO>(boxNameDataVO);
  }
}
