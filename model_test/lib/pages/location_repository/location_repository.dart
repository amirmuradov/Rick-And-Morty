import 'package:fpdart/fpdart.dart';
import 'package:model_test/api/apiclient.dart';
import 'package:model_test/model/location_model.dart';

class LocationRepository {
  ApiClient apiClient = ApiClient();

  Future<Either<Exception, List<LocationModel>>> getLocation() async {
    final response = await apiClient.get<List<LocationModel>>(
      'locations/',
      fromJson: (json) {
        final results = json['locations'] as List;
        return results
            .map((locationsJson) => LocationModel.fromJson(locationsJson))
            .toList();
      },
    );
    return response;
  }
}
