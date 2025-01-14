import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/bloc_observer.dart';
import 'package:movies/config/custom_theme.dart';
import 'package:movies/networking/client/client.dart';
import 'package:movies/networking/repository/movie_repository.dart';
import 'package:movies/pages/search_page/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  runApp(
    MovieApp(
      movieRepository: RemoteMovieRepository(client: APIClient(Dio())),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({
    super.key,
    required this.movieRepository,
  });
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) =>
      RepositoryProvider<MovieRepository>.value(
        value: movieRepository,
        child: MaterialApp(
          title: 'Flutter Demo',
          themeMode: ThemeMode.dark,
          theme: CustomTheme.darkTheme,
          home: const SearchPage(),
        ),
      );
}
