import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import '../models/contact.dart';

Future<List<Contact>> getContactsFromJSON(BuildContext context) async {
  List<Contact> listOfContacts = <Contact>[];
  String str = await DefaultAssetBundle.of(context).loadString('assets/data.json');
  List<dynamic> parsedJSON = jsonDecode(str);
  //return parsedJSON.map((e) => Contact.fromJSON(e)).toList();    /////   tutorial's way
  parsedJSON.forEach((element) {                                   /////    my WAY :D
    listOfContacts.add(Contact(element["name"], element["email"], element["age"]));
  });
  return listOfContacts;

}

Future<List<Contact>> getContactsFromXML(BuildContext context) async {
  String str = await DefaultAssetBundle.of(context).loadString('assets/data.xml');
  var raw = xml.XmlDocument.parse(str);
  var elements = raw.findAllElements("contact");
  return elements.map((e) => Contact(
      e.findElements("name").first.text,
      e.findElements("email").first.text,
      int.parse(e.findElements("age").first.text))).toList();

}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('parse json and xml example'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getContactsFromJSON(context),
          //future: getContactsFromXML(context),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<Contact> contacts = snapshot.data;
              return ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contacts[index].getName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  subtitle: Text(contacts[index].getEmail),
                );
              },itemCount: contacts.length,);
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
