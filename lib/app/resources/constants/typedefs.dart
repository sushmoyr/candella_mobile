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
