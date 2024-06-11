import 'package:finwise/src/ui/home_view.dart';
import 'package:finwise/src/ui/signin_view.dart';
import 'package:finwise/src/ui/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/welcome_view.dart';

class RouteGenerator {

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeView.id:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case WelcomeView.id:
        return MaterialPageRoute(builder: (context) => const WelcomeView());
      case SignInView.id:
        return MaterialPageRoute(builder: (context) => const SignInView());
      case SignUpView.id:
        return MaterialPageRoute(builder: (context) => const SignUpView());

      // case NewsListScreen.id:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<NewsBloc>.value(
      //       value: NewsBloc(),
      //       child: const NewsListScreen(),
      //     ),
      //   );
      //
      // case NewsDetailSliderScreen.id:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return NewsDetailSliderScreen(newsList: args as List<Article>);
      //     },
      //   );
      //
      // case NewsDetailScreen.id:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return NewsDetailScreen(articleData: args as Article);
      //     },
      //   );
      //
      // case CountryListScreen.id:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<CountryBloc>.value(
      //       value: CountryBloc(),
      //       child: const CountryListScreen(),
      //     ),
      //   );
      //
      // case CountryListCenterScreen.id:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<CountryBloc>.value(
      //       value: CountryBloc(),
      //       child: CountryListCenterScreen(selectedCountry: args as String),
      //     ),
      //   );
      //
      // case NewsListPaginationScreen.id:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<NewsBloc>.value(
      //       value: NewsBloc(),
      //       child: const NewsListPaginationScreen(),
      //     ),
      //   );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error while loading new page'),
        ),
      );
    });
  }
}