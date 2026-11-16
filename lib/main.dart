import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_pallete.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/blog/data/repositories/blog_repository.dart';
import 'features/blog/presentation/bloc/blog_cubit.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('blog_app');

  getIt.registerLazySingleton<BlogRepository>(() => BlogRepository());

  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogCubit(getIt<BlogRepository>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BlogVerse',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppPalette.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppPalette.background,
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppPalette.accent,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const SignupPage(),
      ),
    );
  }
}
