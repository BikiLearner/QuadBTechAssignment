
class Movie {
  final int id;
  final String url;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final String status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final String? ended;
  final String? officialSite;
  final Schedule? schedule;
  final Rating? rating;
  final int weight;
  final Network? network;
  final WebChannel? webChannel;
  final Image? image;
  final String summary;

  Movie({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    required this.weight,
    this.network,
    this.webChannel,
    this.image,
    required this.summary,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'],
    url: json['url'],
    name: json['name'],
    type: json['type'],
    language: json['language'],
    genres: List<String>.from(json['genres']),
    status: json['status'],
    runtime: json['runtime'],
    averageRuntime: json['averageRuntime'],
    premiered: json['premiered'],
    ended: json['ended'],
    officialSite: json['officialSite'],
    schedule: json['schedule'] != null
        ? Schedule.fromJson(json['schedule'])
        : null,
    rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    weight: json['weight'],
    network:
    json['network'] != null ? Network.fromJson(json['network']) : null,
    webChannel: json['webChannel'] != null
        ? WebChannel.fromJson(json['webChannel'])
        : null,
    image: json['image'] != null ? Image.fromJson(json['image']) : null,
    summary: json['summary'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'name': name,
    'type': type,
    'language': language,
    'genres': genres,
    'status': status,
    'runtime': runtime,
    'averageRuntime': averageRuntime,
    'premiered': premiered,
    'ended': ended,
    'officialSite': officialSite,
    'schedule': schedule?.toJson(),
    'rating': rating?.toJson(),
    'weight': weight,
    'network': network?.toJson(),
    'webChannel': webChannel?.toJson(),
    'image': image?.toJson(),
    'summary': summary,
  };
}

class Schedule {
  final String time;
  final List<String> days;

  Schedule({required this.time, required this.days});

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    time: json['time'],
    days: List<String>.from(json['days']),
  );

  Map<String, dynamic> toJson() => {
    'time': time,
    'days': days,
  };
}

class Rating {
  final double? average;

  Rating({this.average});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    average: (json['average'] is int)
        ? (json['average'] as int).toDouble()
        : json['average'],
  );

  Map<String, dynamic> toJson() => {
    'average': average,
  };
}


class Network {
  final int id;
  final String name;
  final Country country;

  Network({required this.id, required this.name, required this.country});

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json['id'],
    name: json['name'],
    country: Country.fromJson(json['country']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'country': country.toJson(),
  };
}

class Country {
  final String name;
  final String code;
  final String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json['name'],
    code: json['code'],
    timezone: json['timezone'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'timezone': timezone,
  };
}

class WebChannel {
  final int id;
  final String name;

  WebChannel({required this.id, required this.name});

  factory WebChannel.fromJson(Map<String, dynamic> json) => WebChannel(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Image {
  final String medium;
  final String original;

  Image({required this.medium, required this.original});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    medium: json['medium'],
    original: json['original'],
  );

  Map<String, dynamic> toJson() => {
    'medium': medium,
    'original': original,
  };
}
