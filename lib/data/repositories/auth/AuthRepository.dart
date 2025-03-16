



import '../../../domain/models/user.dart';

abstract class AuthRepository
{
   Future<void> login(String username , String password ) ;
   Future<User> getUser(String username ) ;

}