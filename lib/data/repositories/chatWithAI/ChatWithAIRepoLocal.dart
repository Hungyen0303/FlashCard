// import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
//
// /*Initially I use two array for saving human chat and bot chat , but now i
// * change a bit , use one array , combine two of them , and human chat first
// * */
//
// class ChatWithAIRepoLocal extends ChatWithAIRepo {
//   Map<String, List<String>> fakeDbLocal = {
//     "Conversation 1": [
//       "Hello, can I ask you some questions?",
//       "Sure, go ahead.",
//       "How to use this word \"ephemeral\"?",
//       "It's a word that means something lasting for a short time.",
//       "Can you give an example of using \"ephemeral\"?",
//       "Sure, it can be used in a sentence like: 'The beauty of the sunset was ephemeral.'",
//       "Thanks for the explanation!",
//       "You're welcome!"
//     ],
//     "Conversation 2": [
//       "Hi there, can I ask you something?",
//       "Of course, what do you want to know?",
//       "What does the word \"serendipity\" mean?",
//       "It means finding something good without looking for it.",
//       "Can you use it in a sentence?",
//       "Sure! 'Meeting you was a wonderful serendipity.'",
//       "That's interesting, thanks!",
//       "No problem!"
//     ],
//     "Conversation 3": [
//       "Hey, do you have a moment?",
//       "Yes, I do. What’s up?",
//       "How do you use the word \"quintessential\"?",
//       "It refers to the most perfect or typical example of a quality or class.",
//       "Can you show me how to use it?",
//       "Absolutely! 'She is the quintessential student.'",
//       "Got it, thanks for your help!",
//       "Happy to help!"
//     ],
//   };
//
//   @override
//   Future<List<String>> loadChat(String nameOfConversation) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     return fakeDbLocal[nameOfConversation] ?? [];
//   }
//
//   @override
//   Future<List<String>> loadConversationList() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     return fakeDbLocal.keys.toList();
//   }
//
//   @override
//   Future<bool> sendMessage(String message, String nameOfConversation) async {
//     fakeDbLocal[nameOfConversation]?.add(message);
//     bool isSuccess = await getMessage(message, nameOfConversation);
//     if (!isSuccess) {
//       fakeDbLocal[nameOfConversation]
//           ?.removeAt(fakeDbLocal[nameOfConversation]!.length - 1);
//     }
//     return isSuccess;
//   }
//
//   @override
//   Future<bool> getMessage(String message, String nameOfConversation) async {
//     await Future.delayed(const Duration(milliseconds: 3000));
//
//     String res = "Sure , this is .... ";
//     fakeDbLocal[nameOfConversation]?.add(res);
//
//     // api call service
//
//     return true;
//   }
// }
