enum FormType { signUp, signIn, reset }

class Gender {
  static const male = 'Male';
  static const female = 'Female';
  static const notSpecified = 'Not Specified';

  static String of(String gender) {
    if (gender == male) {
      return male;
    }
    if (gender == female) {
      return female;
    }
    if (gender == notSpecified) {
      return notSpecified;
    }
    throw Exception('Invalid Gender');
  }
}

enum ProfileType { self, other }

class Category {
  final String id;
  final String name;

  const Category(this.id, this.name);

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(json['_id'], json['name']);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};

  static const Category story = Category("61afda37f402ce41f5d21bec", "Story");
  static Category novel = Category("61afdb9031d1cebfa2b3e438", "Novel");
  static Category poem = Category("61afdb9231d1cebfa2b3e43c", "Poem");
  static Category comic = Category("61afdb9331d1cebfa2b3e441", "Comic");
  static Category journal = Category("61afdb9331d1cebfa2b3e443", "Journal");
  static Category photography =
      Category("61afdb9331d1cebfa2b3e445", "Photography");

  static List<Category> categoryData = [
    story,
    novel,
    poem,
    comic,
    journal,
    photography
  ];
}

Category getCategoryById(String id) {
  for (Category category in Category.categoryData) {
    if (category.id == id) {
      return category;
    }
  }
  throw Exception('There is no category with id: $id');
}

enum ChapterMode { photography, comic, other }

/*
[{
  "_id": {
    "$oid": "61afdb9331d1cebfa2b3e443"
  },
  "name": "Journal"
},{
  "_id": {
    "$oid": "61afdb9331d1cebfa2b3e445"
  },
  "name": "Photography"
}]
 */
