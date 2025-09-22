import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'flywind_generator.dart';

/// FlyWind builder factory for source_gen
Builder flywindBuilder(BuilderOptions options) {
  return SharedPartBuilder([FlywindGenerator()], 'flywind');
}
