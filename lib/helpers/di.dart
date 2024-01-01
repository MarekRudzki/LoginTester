import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:login_tester/helpers/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
