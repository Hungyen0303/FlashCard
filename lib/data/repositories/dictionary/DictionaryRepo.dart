

import 'package:flashcard_learning/domain/models/Word.dart';

abstract class DictionaryRepo {
   Future<Word > getWord(String text) ;
   Future<List<Word>> getPopularWord() ;
 }