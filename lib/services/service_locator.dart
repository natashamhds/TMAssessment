import 'package:get_it/get_it.dart';
import 'package:tm_assessment/view%20model/home_viewmodel.dart';

GetIt serviceLocator = GetIt.instance;

Future setupServiceLocator() async {
  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
}