



import 'package:dio/dio.dart';

Future<void> main() async {



  Response rs = await Dio().get<String>(
    "https://reqres.in/api/users?page=2" ,
    options: Options(responseType: ResponseType.plain  ), // Set the response type to `bytes`.
  );
  String a = "123" ;
  print(a[1]);
 print(rs.statusCode); // Type: List<int>.


}