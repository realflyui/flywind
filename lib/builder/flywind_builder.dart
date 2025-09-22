import 'package:build/build.dart';
import 'flywind_generator.dart';

/// FlyWind builder factory for YAML-based generation
/// Uses source_gen utilities for better integration with the build system
Builder flywindYamlBuilder(BuilderOptions options) {
  return FlywindBuilder();
}
