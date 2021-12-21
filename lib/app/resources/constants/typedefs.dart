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

  Category(this.id, this.name);

  static List<Category> categoryData = [
    Category("61afda37f402ce41f5d21bec", "Story"),
    Category("61afdb9031d1cebfa2b3e438", "Novel"),
    Category("61afdb9231d1cebfa2b3e43c", "Poem"),
    Category("61afdb9331d1cebfa2b3e441", "Comic"),
    Category("61afdb9331d1cebfa2b3e443", "Journal"),
    Category("61afdb9331d1cebfa2b3e445", "Photography"),
  ];
}

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
