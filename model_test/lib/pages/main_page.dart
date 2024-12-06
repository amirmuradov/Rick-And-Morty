import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_test/repository/bloc/character_bloc.dart';
import 'package:model_test/model/character_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rick And Morty'),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CharacterLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CharacterLoaded) {
            final List<Character> characters = state.character;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                  ),
                  title: Text(character.name),
                  subtitle: Text('${character.species} - ${character.status}'),
                  onTap: () {},
                );
              },
            );
          } else if (state is CharacterError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
