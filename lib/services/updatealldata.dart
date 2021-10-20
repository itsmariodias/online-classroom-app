


import 'package:classroom/data/accounts_data.dart';
import 'package:classroom/data/classrooms.dart';

Future<bool> updateAllData() async
{
  print("\t\t\t\t\tupdate Started");
  
  await getListAccount();
  await getStudentAndClasses();
  await getListClasses();


  print("\t\t\t\t\tUpdate Finished");
  return true;

}