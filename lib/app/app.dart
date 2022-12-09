import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';
import 'package:lat_long_collector/app/view/form/page.dart';

class App extends StatelessWidget {
  const App({
    required this.kakaoAddressHandler,
    Key? key,
  }) : super(key: key);

  final KakaoAddressHandler kakaoAddressHandler;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: kakaoAddressHandler),
        RepositoryProvider(create: (context) => DevLogger()),
      ],
      child: const AppLandscape(),
    );
  }
}

class AppLandscape extends StatelessWidget {
  const AppLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [],
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        return const AppView();
      },
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAT LONG COLLECTOR',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardSearchPage(),
    );
  }
}
