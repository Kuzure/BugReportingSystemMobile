import 'package:equatable/equatable.dart';

class UserData extends Equatable{
final String FirstName;
final String LastName;
final String PhoneNumber;
const UserData({required this.FirstName,required this.LastName,required this.PhoneNumber});

  @override
  // TODO: implement props
  List<Object> get props => [FirstName,LastName,PhoneNumber];
}