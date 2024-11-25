import 'package:fpdart/fpdart.dart';
import 'package:model_test/api/apiclient.dart';
import 'package:model_test/model/character_model.dart';

class Repository {
  Future<Either<Exception, List<Character>>> getCharacter() async {
    ApiClient apiClient = ApiClient();

    final response = apiClient.get<List<Character>>(
      'character/',
      fromJson: (json) {
        final results = json['results'] as List;
        return results
            .map(
              (charactersJson) => Character.fromJson(charactersJson),
            )
            .toList();
      },
    );
    return response;
  }
}
