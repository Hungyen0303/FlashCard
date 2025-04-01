class Prompt {
  static List<String> promptsForChat = [
    "Chat just for learning English , if the 'content ' is not related. Answer ' $notRelated ",
  ];

  static String notRelated = "This chat just for learning english . "
      "Please ask me a question related to english , I will answer for you 😀😀";

  static List<String> promptsForConversation = [
    "Chat just for learning English , if the 'content ' is not related. Answer 'Not related to learning english"
        " , please ask question related to it "
  ];

  static String promptsForGetQuestion(topic, level) => '''
  Please give me 5 question related to this topic $topic with level $level.
  The question should be not more than 200 characters .
  Your answer should be response follow this format:
  Question 1 % Question 2 %  Question 3 % Question 4 % Question 5
  ''';

  static String getPromptForChat() {
    return promptsForChat.join(".");
  }

  static String getPromptForConversation() {
    return promptsForConversation.join(".");
  }

  static String promptForGettingTopic = '''
                                  I want you to do this thing for me 
                                  Give me 3 topic for learning english 
                                  For example : “ School , education , animals , …” 
                                  Please random the answer , do not use the same answer for each time i ask 
                                  Your answer should be response follow this format 
                                  Topic 1 , Topic 2 , Topic 3
                                    ''';

  static String promptForGettingTitleFromTopic(String topic) => '''
      I want you to do this thing for me 
      Give me a title for each topic I provides. 
      Topic is $topic 
      For example : if topic is school , title could be : English at school 
      The title must be simple , easy to understand
      if topic is school , title could be : English at school 
      if topic is home,   , title could be clean the hours 
      Your answer should be response follow this format: 
      Title 1 , Title 2 , Title 3
      
      ''';

  static String promptForGetScoreAndQuestion(
          String answer, String question, String nextQuestion) =>
      '''
      I want you to do this thing for me. 
      First lets grade this answer ${answer}  for this question : ${question}
      in scale 1 to 10.
      For example , if the answer is basic give from 1 to 5 
      if answer is immediate , give score from 6 to 8 
      if answer is good  , give score from 8 to 10 
      if it is too short , consider it as basic. 
      Remember to score honestly , base on vocabulary , length of answer , grammar , 
      the way to use sentence 
      And then send back this question for me : $nextQuestion?
       , bear in mind that do not change my question.
      Please answer follows this format , note: remember your_score is in position 7   : 
      Score : your_score 
      New Question : Question_back
      Shortly Explain why that score
      ''';

  static String promptForLastQuestion(String humanChat, String question) => '''
      I want you to do this thing for me. 
      First lets grade this answer {I like fish }  for this question : {What is you favorites animals }
      in scale 1 to 10.
      Please answer follows this format : 
      Score : your_score 
      ''';

  static String promptForGettingPopularWord() => '''
      I want you to recommend for me four english word in order to learning english
      the level is middle , there are just a word like eligible , constant , ... 
      
      Please answer follows this format and remove  in the end : 
      word1%word2%word3%word4%
      ''';
}
