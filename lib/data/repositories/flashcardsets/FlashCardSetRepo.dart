import 'package:flashcard_learning/domain/models/flashSet.dart';

abstract class FlashCardSetRepo {
  Future<List<FlashCardSet>> getAll();

  Future<List<FlashCardSet>> getAllSetPublic();



  Future<bool> addNewSet(FlashCardSet newSet);

  Future<bool> addNewSetToPublic(FlashCardSet newSet);


  Future<bool> editASet(String nameOfSet, FlashCardSet newSet);

  Future<bool> deleteASet(String name);
}
