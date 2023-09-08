import 'package:get_it/get_it.dart';
import 'package:app_qr/auth/infrastructure/data/api/auth_data_source.dart';
import 'package:app_qr/auth/infrastructure/repositories/auth_repository.dart';
import 'package:app_qr/auth/services/auth_service.dart';

final GetIt locator = GetIt.instance;

initInjectable(){
  // Authorization
  locator.registerFactory<AuthDataSource>(() => AuthDataSource());
  locator.registerFactory<AuthRepository>(() => AuthRepository(locator.get()));
  locator.registerFactory<AuthService>(() => AuthService(locator.get()));

  
}