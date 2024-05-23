import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dictionary/bloc/word_cubit.dart';
import 'package:flutter_dictionary/pages/display_page.dart';
import 'package:flutter_dictionary/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/display",
        builder: (context, state) => BlocProvider<WordCubit>(
          create: (context) => WordCubit(),
          child: DisplayPage(
            searchWord: state.extra as String,
          ),
        ),
      )
    ],
  );
}
