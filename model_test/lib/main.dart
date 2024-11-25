import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_test/pages/main_page.dart';
import 'package:model_test/repository/bloc/character_bloc.dart';
import 'package:model_test/repository/repository.dart';

Future<void> main() async {
  final repository = Repository();
  runApp(
    MyApp(
      repository: repository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Repository repository;
  const MyApp({super.key, required this.repository});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CharacterBloc(repository: repository)
          ..add(
            GetCharactersEvent(),
          ),
        child: const MainPage(),
      ),
    );
  }
}
