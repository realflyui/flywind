// Simple test to verify custom token usage
import 'lib/tokens/color.dart';
import 'lib/custom_tokens/custom_colors.dart';

void main() {
  print('🎨 Testing custom token usage...');
  
  // Test colors
  final colors = FlyColors.defaultColors;
  
  print('\n📄 Testing dot notation:');
  print('colors.brandPrimary: ${colors.brandPrimary}');
  
  print('\n📄 Testing array lookup:');
  print('colors["brand-primary"]: ${colors["brand-primary"]}');
  print('colors["red500"]: ${colors["red500"]}');
  
  print('\n📄 Testing default colors still work:');
  print('colors.red500: ${colors.red500}');
  
  print('\n✅ Test completed!');
}
