import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseService {
  static final PROJECT_ID = "vuxrufezkmjtjdkwdjmy";
  static final URL = "https://$PROJECT_ID.supabase.co";
  static final anonKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ1eHJ1ZmV6a21qdGpka3dkam15Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIyODIwNzAsImV4cCI6MjA1Nzg1ODA3MH0.ZSCJazbiEFc4QSpNSIUlpq0SVnEGnE32Isgky6LhmL4";
  static final bucketName = "flashcard";

  static final supabase = Supabase.instance.client;

  static Future<String> uploadImageToSupabase(String path, String name) async {
    File file = File(path);

    try {
      final bytes = await file.readAsBytes();
      final fileExt = file.path.split('.').last;
      final date = DateTime.now().toString();
      final fileName = '$date.$fileExt';
      final filePath = fileName;
      await supabase.storage.from(bucketName).uploadBinary(
            filePath,
            bytes,
          );
      return supabase.storage.from(bucketName).getPublicUrl(filePath);
    } on StorageException catch (error) {
      print("Error : " + error.message);
    } catch (error) {
      print("Error: ");
      print(error);
    }
    return "";
  }
}
