import 'package:dio/dio.dart';
import 'package:rickmorty/models/character.dart';
import 'api_service.dart';



class RickMortyService {
  final ApiService _apiService;

  RickMortyService(this._apiService);

  Future<CharactersResponse> getAllCharacters({
    int page =1,
    String?name,
    String?status,
    String?species,
    String?type,
    String?gender,
  }) async {
    final queryParams =<String,dynamic>{
      'page':page,
      if(name != null) 'name': name,
      if(status != null) 'status': status,
      if(species != null) 'species': species,
      if(type != null) 'type': type,
      if(gender != null) 'gender': gender,  
    };
    try {
      final response=await _apiService.get('/character', queryParameters: queryParams);
      
      if (response is Map<String,dynamic>){
        return CharactersResponse.fromJson(response);
      } else {
        throw const FormatException('risposta non valida');
      }
    } catch (e){
      rethrow;
    }
  }
  Future<Character> getCharacterById(int id) async {
    try {
      final response = await _apiService.get('/character/$id');
      if (response is Map<String, dynamic>) {
        return Character.fromJson(response);
      } else {
        throw const FormatException('Risposta non valida');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Character>> getCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) {
      return [];
    };
    try {
      final response = await _apiService.get('/character/${ids.join(',')}');
      if (response is List){
        return response.map((e)=> Character.fromJson(e as Map<String, dynamic>)).toList();
      } else if (response is Map<String, dynamic>) {
        return [Character.fromJson(response)];
      } else {
        throw const FormatException("formato inaspoettato");
      }
    }  catch (e) {
      rethrow;
    }
  }

}
