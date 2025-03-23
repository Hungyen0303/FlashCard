// import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
//
// import '../../../domain/models/Flashcard.dart';
//
// class SpecificFlashCardRepoLocal extends SpecificFlashCardRepo {
//   Map<String, List<FlashCard>> fakeDatabase = {
//     "FlashCard Set 0": [
//       FlashCard("vietnamese", "tiếng việt", "Ví dụ: Tôi nói tiếng Việt."),
//       FlashCard("english", "tiếng anh", "Ví dụ: I speak English."),
//       FlashCard("thailand", "tiếng thái", "Ví dụ: Tôi học tiếng Thái."),
//       FlashCard("french", "tiếng pháp", "Ví dụ: Tôi thích tiếng Pháp."),
//       FlashCard("japanese", "tiếng nhật", "Ví dụ: Tôi học tiếng Nhật."),
//     ],
//     "FlashCard Set 1": [
//       FlashCard("american", "tiếng anh(mỹ)", "Ví dụ: Tôi nghe tiếng Anh Mỹ."),
//       FlashCard("russia", "tiếng nga", "Ví dụ: Tôi học tiếng Nga."),
//       FlashCard(
//           "cambodia", "tiếng campuchia", "Ví dụ: Tôi thích tiếng Campuchia."),
//       FlashCard(
//           "spanish", "tiếng tây ban nha", "Ví dụ: Tôi học tiếng Tây Ban Nha."),
//       FlashCard("chinese", "tiếng trung", "Ví dụ: Tôi học tiếng Trung."),
//     ],
//     "FlashCard Set 2": [
//       FlashCard("german", "tiếng đức", "Ví dụ: Tôi học tiếng Đức."),
//       FlashCard("korean", "tiếng hàn", "Ví dụ: Tôi thích tiếng Hàn."),
//       FlashCard("italian", "tiếng ý", "Ví dụ: Tôi học tiếng Ý."),
//       FlashCard("portuguese", "tiếng bồ đào nha",
//           "Ví dụ: Tôi nghe tiếng Bồ Đào Nha."),
//       FlashCard("arabic", "tiếng ả rập", "Ví dụ: Tôi học tiếng Ả Rập."),
//     ],
//   };
//
//   String nameOfSet = "";
//
//   @override
//   void setNameOfSet(String newName) {
//     nameOfSet = newName;
//   }
//
//   @override
//   Future<List<FlashCard>> getAll() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     return fakeDatabase[nameOfSet] ?? [];
//   }
//
//   @override
//   Future<bool> addNewCard(FlashCard flashcard) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     if (fakeDatabase[nameOfSet] != null) {
//       fakeDatabase[nameOfSet]?.add(flashcard);
//     } else {
//       fakeDatabase.addAll({
//         nameOfSet: List.of([flashcard])
//       });
//     }
//
//     return true;
//   }
//
//   @override
//   Future<bool> deleteACard(FlashCard card) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     List<FlashCard> current = fakeDatabase[nameOfSet] ?? [];
//     current.remove(card);
//     return true;
//   }
//
//   @override
//   Future<bool> editACard(FlashCard oldCard, FlashCard newCard) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     List<FlashCard> current = fakeDatabase[nameOfSet] ?? [];
//     for (int i = 0; i < current.length; i++) {
//       if (oldCard == current[i]) current[i] = newCard;
//     }
//
//     return true;
//   }
// }
