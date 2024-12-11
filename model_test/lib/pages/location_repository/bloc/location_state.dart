part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationFailed extends LocationState {
  final String error;
  final String stackTrace;

  const LocationFailed({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

final class LocationFail extends LocationState {
  final String error;
  const LocationFail(this.error);

  @override
  List<Object> get props => [error];
}

final class LocationLoaded extends LocationState {
  final List<LocationModel> data;

  const LocationLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

final class LocationLoading extends LocationState {}
