import 'package:build/build.dart';
import 'custom_token_generator.dart';

/// FlyWind builder factory for YAML-based generation
/// Uses source_gen utilities for better integration with the build system
Builder customTokenBuilder(BuilderOptions options) {
  return CustomTokenBuilder();
}
