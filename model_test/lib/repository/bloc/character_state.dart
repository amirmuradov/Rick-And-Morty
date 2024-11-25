part of 'character_bloc.dart';

sealed class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoadingFailed extends CharacterState {
  final String message;

  const CharacterLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class CharacterError extends CharacterState {
  final String error;
  const CharacterError(this.error);

  @override
  List<Object> get props => [error];
}

class CharacterLoaded extends CharacterState {
  final List<Character> character;

  const CharacterLoaded({required this.character});

  @override
  List<Object?> get prop => [character];
}
