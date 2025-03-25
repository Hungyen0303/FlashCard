class Prompt {
  static List<String> promptsForChat = [
    "Chat just for learning English , if the 'content ' is not related. Answer ' $notRelated " ,



  ];

  static String notRelated = "This chat just for learning english . "
      "Please ask me a question related to english , I will answer for you 😀😀";

  static List<String> promptsForConversation = [
    "Chat just for learning English , if the 'content ' is not related. Answer 'Not related to learning english"
        " , please ask question related to it "
  ];

  static String getPromptForChat() {
    return promptsForChat.join(".");
  }

  static String getPromptForConversation() {
    return promptsForConversation.join(".");
  }
}
