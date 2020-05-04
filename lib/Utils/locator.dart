

import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/customNavigator/customNavigation.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingleton(CallService());
}


  