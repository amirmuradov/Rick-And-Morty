import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_test/pages/location_repository/bloc/location_bloc.dart';
import 'package:model_test/pages/main_page.dart';
import 'package:model_test/repository/bloc/character_bloc.dart';
import 'package:model_test/repository/repository.dart';

import 'pages/location_repository/location_repository.dart';

Future<void> main() async {
  final repository = Repository();
  final locationrepo = LocationRepository();
  runApp(
    RepositoryProvider(
      create: (context) => repository,
      child: MyApp(
        repository: repository,
        locationRepository: locationrepo,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Repository repository;
  final LocationRepository locationRepository;
  const MyApp(
      {super.key, required this.repository, required this.locationRepository});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CharacterBloc(repository: repository)
              ..add(
                GetCharactersEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => LocationBloc(repository: locationRepository)
              ..add(
                GetLocationEvent(),
              ),
          ),
        ],
        child: const MainPage(),
      ),
    );
  }
}
