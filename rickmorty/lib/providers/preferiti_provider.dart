import 'package:flutter/cupertino.dart';
import 'package:rickmorty/models/character.dart';
class PreferitiProvider extends ChangeNotifier{
  int _numeroPreferiti = 0;
  List<Character> _preferiti=[];
  //GETTER PER ACCEDERE ALLA VARIABILE PRIVATA
  int get numeroPreferiti => _numeroPreferiti;
  //get per la lista della pagina preferiti
  List<Character> get preferiti => _preferiti;
  //METODO INCREMENTO 
  void addPreferito(Character character){
    if(!isPreferito(character)){
      _preferiti.add(character);
      _numeroPreferiti ++;
      notifyListeners();
    }
  }
  void rimuoviPreferito(Character character){
    if(isPreferito(character)){
      _preferiti.remove(character);
      _numeroPreferiti--;
      notifyListeners();
    }
  }
  bool isPreferito(Character character){
    return _preferiti.any((p)=>p.id==character.id);
  }
}