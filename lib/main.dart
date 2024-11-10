import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peakbit_blog/blocs/article/article_cubit.dart';
import 'package:peakbit_blog/screens/article/article_screen.dart';
import 'package:peakbit_blog/screens/article_list/article_list_screen.dart';
import 'package:peakbit_blog/services/network_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'blocs/article_list/article_list_cubit.dart';

void main() {
  NetworkService.instance.setupDio().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleListCubit>(create: (_) => ArticleListCubit()),
        BlocProvider<ArticleCubit>(create: (_) => ArticleCubit()),
      ],
      child: MaterialApp(
        title: 'PeakBit Blog',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('hu'),
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const ArticleListScreen(),
      ),
    );
  }
}