class Contact {
  String _name,_email;
  int _age;

  Contact(this._name,this._email,this._age);

  factory Contact.fromJSON(Map<String,dynamic> json) {
    if(json == null) {
      return null;
    }else{
      return Contact(json["name"], json["email"], json["age"]);
    }
  }

  String get getName => _name;
  String get getEmail => _email;
  int get getAge => _age;

}
