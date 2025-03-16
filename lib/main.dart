import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/theme.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/init_dependencies.dart';
import 'package:muhammad_faheem_amin_tentwenty_assignment/routing/app_route_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    ScreenUtilInit(
      designSize: const Size(375, 812),
      // minTextAdapt: true,
      builder:
          (BuildContext context, child) => BlocProvider(
            create:
                (context) =>
                    serviceLocator<MoviesBloc>()
                      ..add(FetchUpcomingMoviesEvent()),
            child: const MyApp(),
          ),
    ),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TenTwenty Assignment',
      theme: AppTheme.lightThemeMode,
      routerConfig: MyAppRouter.router,
    );
  }
}
