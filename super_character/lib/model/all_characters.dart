class AllCharacters {
  int id;
  String name;
  String slug;
  Powerstatus powerstatus;
  Appearance appearance;
  Biography biography;
  Work work;
  Connections connections;
  Images images;
  
  AllCharacters(this.id,this.name,this.slug,this.powerstatus,this.appearance,this.biography,this.work,this.connections,this.images);
  
  AllCharacters.fromJson(Map<String,dynamic> json)
    : id = json['id'],
      name = json['name'],
      slug = json['slug'],
      powerstatus = Powerstatus.fromJson(json['powerstats']),
      appearance = Appearance.fromJson(json['appearance']),
      biography = Biography.fromJson(json['biography']),
      work = Work.fromJson(json['work']),
      connections = Connections.fromJson(json['connections']),
      images = Images.fromJson(json['images']); 
}

class Powerstatus{
  int intelligence;
  int strength;
  int speed;
  int durability;
  int power;
  int combat;

  Powerstatus(this.intelligence,this.strength,this.speed,this.durability,this.power,this.combat);

  Powerstatus.fromJson(Map<String,dynamic> json)
  : intelligence = json['intelligence'],
  strength = json['strength'],
  speed = json['speed'],
  durability = json['durability'],
  power = json['power'],
  combat = json['combat'];
}

class Appearance{
  String gender;
  String? race;
  List<String> height;
  List<String> weight;
  String eyeColor;
  String hairColor;

  Appearance(this.gender,this.race,this.height,this.weight,this.eyeColor,this.hairColor);

  Appearance.fromJson(Map<String,dynamic> json)
  : gender = json['gender'],
  race = json['race'],
  height = List<String>.from(json['height'].map((x) => x)),
  weight = List<String>.from(json['weight'].map((x) => x)),
  eyeColor = json['eyeColor'],
  hairColor = json['hairColor'];
}

class Biography{
  String fullName;
  String alterEgos;
  List<String> aliases;
  String placeOfBirth;
  String firstAppearance;
  String? publisher;
  String alignment;
  
  Biography.fromJson(Map<String,dynamic> json)
    :fullName = json['fullName'],
    alterEgos = json['alterEgos'],
    aliases = List<String>.from(json['aliases'].map((x) => x)),
    placeOfBirth = json['placeOfBirth'],
    firstAppearance = json['firstAppearance'],
    publisher = json['publisher'],
    alignment = json['alignment'];
}


class Work{
  String occupation;
  String base;

  Work(this.occupation,this.base);

  Work.fromJson(Map<String,dynamic> json)
  : occupation = json['occupation'],
  base = json['base'];
}


class Connections{
  String groupAffiliation;
  String relatives;

  Connections(this.groupAffiliation,this.relatives);

  Connections.fromJson(Map<String,dynamic> json)
  : groupAffiliation = json['groupAffiliation'],
  relatives = json['relatives'];
}


class Images{
  String xs;
  String sm;
  String md;
  String lg;

  Images(this.xs,this.sm,this.md,this.lg);

  Images.fromJson(Map<String,dynamic> json)
  : xs = json['xs'],
  sm = json['sm'],
  md = json['md'],
  lg = json['lg'];
}