


import 'package:classroom/data/accounts_data.dart';

Future<bool> updateAllData() async
{

  print("\t\t\t\t\tupdate Started");
  await getListAccount();


  print("\t\t\t\t\tUpdate Finished");
  return true;

}