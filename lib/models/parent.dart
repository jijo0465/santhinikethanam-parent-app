class Parent {
  int _personId;
  int _id;
  String _name;
  String _password;
  String _phoneNumberPrimary;
  String _phoneNumberSecondary;
  String _email;
  String _photoUrl;
  String _occupation;

  get personId => _personId;
  get id => _id;
  get name => _name;
  get password => _password;
  get phoneNumberPrimary => _phoneNumberPrimary;
  get phoneNumberSecondary => _phoneNumberSecondary;
  get email => _email;
  get photoUrl => _photoUrl;
  get occupation => _occupation;

  Parent(int id, String name, String password, int personId, String phoneNumberPrimary, String phoneNumberSecondary, String email,
      String photoUrl, String occupation) {
    this._personId = personId;
    this._id = id;
    this._name = name;
    this._password = password;
    this._phoneNumberPrimary = phoneNumberPrimary;
    this._phoneNumberSecondary = phoneNumberSecondary;
    this._email = email;
    this._photoUrl = photoUrl;
    this._occupation = occupation;
  }

  setId(int id) {
    this._id = id;
  }

  setName(String name) {
    this._name = name;
  }

  factory Parent.fromMap(Map<String, dynamic> value) {
    Parent parent = Parent(
      value['personId'], 
      value['id'], 
      value['name'], 
      value['password'],
      value['phoneNumberPrimary'],
      value['phoneNumberSecondary'],
      value['email'],
      value['photoUrl'],
      value['occupation']);
    return parent;
  }
}
