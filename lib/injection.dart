import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> setupDi(String environment) => $initGetIt(getIt);

abstract class Env {
  static const test = 'test';
  static const dev = 'dev';
  static const prod = 'prod';
}
