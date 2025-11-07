library;

// Auto-generation hook
import 'dart:io';

import 'package:path/path.dart' as path;

// Core exports
export 'core/core.dart';
export 'mixins/helpers.dart';
// Theme exports
export 'theme/color_generator.dart';
export 'theme/radix_colors.dart';
export 'tokens/tokens.dart';
export 'widgets/widgets.dart';

/// Initialize Flywind and ensure tokens are generated
/// This should be called in your main() function
void initializeFlywind() {
  // Check if tokens file exists, if not, suggest running build_runner
  final currentDir = Directory.current;
  final tokensFile = File(
    path.join(currentDir.path, 'lib', 'flw', 'tokens', 'tokens.dart'),
  );

  if (!tokensFile.existsSync()) {
    print('⚠️  Flywind tokens not found!');
    print('   Run: dart run build_runner build');
    print('   Or use the setup script: ./setup.sh');
  }
}
