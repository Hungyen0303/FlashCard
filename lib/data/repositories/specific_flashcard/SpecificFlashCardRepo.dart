

import 'package:flashcard_learning/domain/models/Flashcard.dart';

abstract class SpecificFlashCardRepo {

  Future<List<FlashCard>> getAll() ;


}