import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseService {
  static final projectId = dotenv.env['SUPABASE_PROJECT_ID'] ?? "";
  static final url = "https://$projectId.supabase.co";
  static final anonKey = dotenv.env['SUPABASE_anonKey'] ?? '';
  static final bucketName = dotenv.env['SUPABASE_bucketName'] ?? 'flashcard';
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
    } catch (error) {}
    return "";
  }
}
