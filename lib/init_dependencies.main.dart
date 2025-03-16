part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  // await HydratedBloc.storage.clear();

  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => InternetConnection());

  //core

  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );

  await _initMovies();
}

Future<void> _initMovies() async {
  serviceLocator
    ..registerFactory<MovieRemoteDatasource>(
      () => MovieRemoteDatasourceImpl(dio: serviceLocator()),
    )
    ..registerFactory<MovieRepository>(
      () => MovieRepositoryImpl(
        connectionChecker: serviceLocator(),
        movieRemoteDatasource: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => GetUpcomingMovies(movieRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => GetTrailerPath(movieRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => MoviesBloc(
        getUpcomingMovies: serviceLocator(),
        getTrailerPath: serviceLocator(),
      ),
    )
    ..registerFactoryParam<SearchMovieBloc, SearchMovieState, void>(
      (initialState, _) => SearchMovieBloc(initialState: initialState),
    );
}
