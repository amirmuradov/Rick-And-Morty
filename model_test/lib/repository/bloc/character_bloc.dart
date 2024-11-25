import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:model_test/model/character_model.dart';
import 'package:model_test/repository/repository.dart';
part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final Repository repository;

  CharacterBloc({required this.repository}) : super(CharacterInitial()) {
    on<GetCharactersEvent>(_onGetCharacters);
  }

  Future<void> _onGetCharacters(
      GetCharactersEvent event, Emitter<CharacterState> emit) async {
    emit(
      CharacterLoading(),
    );
    try {
      final response = await repository.getCharacter();
      response.fold(
        (exception) {
          emit(
            CharacterLoadingFailed(
              exception.toString(),
            ),
          );
        },
        (characters) {
          emit(
            CharacterLoaded(character: characters),
          );
        },
      );
    } catch (e, s) {
      emit(
        CharacterError(
          'Unexpected error occurred: $e, $s',
        ),
      );
    }
  }
}
