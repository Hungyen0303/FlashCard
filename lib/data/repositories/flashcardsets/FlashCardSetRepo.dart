import 'package:flashcard_learning/domain/models/flashSet.dart';

abstract class FlashCardSetRepo {
  Future<List<FlashCardSet>> getAll();

  Future<bool> addNewSet(FlashCardSet newSet);

  Future<bool> editASet(FlashCardSet oldSet, FlashCardSet newSet);

  Future<bool> deleteASet(String name);
}
