

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;



Character({
  required this.id,
  required this.name,
  required this.status,
  required this.species,
  required this.type,
  required this.gender,
  required this.origin,
  required this.location,
  required this.image,
  required this.episode,
  required this.url,
  required this.created,      
});

factory Character.fromJson(Map<String,dynamic> json){
  return Character(
    id:json['id'] as int,
    name:json['name'] as String,
    status:json['status'] as String,
    species:json['species'] as String,
    type:json['type'] as String,
    gender:json['gender'] as String,
    origin: Location.fromJson(json['origin'] as Map<String,dynamic>),
    location: Location.fromJson(json['location'] as Map<String,dynamic>),
    image:json['image'] as String,
    episode:List<String>.from(json['episode'] as List),
    url:json['url'] as String,
    created:DateTime.parse(json['created'] as String),
  );
}

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'origin': origin.toJson(),
    'location': location.toJson(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created,
  };
}
}
class CharactersResponse {
  final Info info;
  final List<Character> results;

  CharactersResponse({required this.info, required this.results});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      info: Info.fromJson(json['info']),
      results: (json['results'] as List)
          .map((char) => Character.fromJson(char))
          .toList(),
    );
  }
}

class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({required this.count, required this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}