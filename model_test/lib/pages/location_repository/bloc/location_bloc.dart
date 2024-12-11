import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:model_test/model/location_model.dart';
import 'package:model_test/pages/location_repository/location_repository.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;

  LocationBloc({required this.repository}) : super(LocationInitial()) {
    on<GetLocationEvent>(_onGetLocation);
  }
  Future<void> _onGetLocation(
      GetLocationEvent event, Emitter<LocationState> emit) async {
    emit(
      LocationLoading(),
    );
    try {
      final response = await repository.getLocation();
      response.fold(
        (exception) => emit(
          LocationFail(
            exception.toString(),
          ),
        ),
        (data) => emit(
          LocationLoaded(data: data),
        ),
      );
    } catch (e, s) {
      emit(
        LocationFailed(
          error: e.toString(),
          stackTrace: s.toString(),
        ),
      );
    }
  }
}
