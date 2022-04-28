import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:student_app/data/vos/movie_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  // save and get all movie to peristence
  void saveAllMovie(List<MovieVO> movieList) async {
    // Map<int, MovieVO> movieMap = {
    //   for (var movie in movieList) movie.id!: movie
    // };

    Map<int, MovieVO> movieMap = Map.fromIterable(
      movieList,
      key: (movie) => movie.id,
      value: (movie) => movie,
    );

    await getMovieBox().putAll(movieMap);
  }

  List<MovieVO> getAllMovie() {
    return getMovieBox().values.toList();
  }

  // List<MovieVO> getNowShowingMovieList() {
  //   return getAllMovie()
  //       .where((movie) => movie.isCurrentMovie ?? false)
  //       .toList();
  // }

  // List<MovieVO> getComingSoonMovieList() {
  //   return getAllMovie()
  //       .where((movie) => movie.isComingSoonMovie ?? false)
  //       .toList();
  // }



  //save and get single movie by id
  void saveSingleMovie(MovieVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  MovieVO getSingleMovie(int movieId) {
    return getMovieBox().get(movieId)!;
  }

  ///Reactive Programming
  Stream<void> getAllMovieEventStream() {
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getAllMovieListStream() {
    return Stream.value(getAllMovie().toList());
  }

  //Stream method 1
  Stream<List<MovieVO>> getNowShowingMovieListStream() {
    return Stream.value(getAllMovie()
        .where((element) => element.isCurrentMovie ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getCommingSoonMovieListStream() {
    return Stream.value(getAllMovie()
        .where((element) => element.isComingSoonMovie ?? false)
        .toList());
  }

  Stream<MovieVO> getMovieDetailsStream(int movieId) {
    return Stream.value(getSingleMovie(movieId));
  }

  //Stream method 2
  Stream<List<MovieVO>> watchNowShowingMovieStream() {
    return getMovieBox().watch().map((event) => getAllMovie()
        .where((element) => element.isCurrentMovie ?? false)
        .toList());
  }

  Stream<List<MovieVO>> watchComingSoonMovieStream() {
    return getMovieBox().watch().map((event) => getAllMovie()
        .where((element) => element.isComingSoonMovie ?? false)
        .toList());
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(boxNameMovieVO);
  }
}
