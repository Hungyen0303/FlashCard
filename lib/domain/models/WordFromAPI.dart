class WordFromAPI {
  WordFromAPI();

  String word = "";
  String phonetics = "";
  String linkAudio = "";

  List<Meaning> meanings = [];
}

class Meaning {
  Meaning.named(String definition, String example)
      : definition = definition,
        example = example;

  String definition = "";

  String example = "";
}
