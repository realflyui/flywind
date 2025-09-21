// Test file to verify custom token usage
import 'package:flywind/tokens/color.dart';
import 'package:flywind/tokens/spacing.dart';
import 'lib/custom_tokens/custom_colors.dart';
import 'lib/custom_tokens/custom_spacing.dart';

void main() {
  print('🎨 Testing custom token usage...');
  
  // Test colors
  final colors = FlyColors.defaultColors;
  
  print('\n📄 Testing dot notation:');
  print('colors.brandPrimary: ${colors.brandPrimary}');
  print('colors.brandSecondary: ${colors.brandSecondary}');
  print('colors.semanticSuccess: ${colors.semanticSuccess}');
  
  print('\n📄 Testing array lookup:');
  print('colors["brand-primary"]: ${colors["brand-primary"]}');
  print('colors["semantic-success"]: ${colors["semantic-success"]}');
  
  print('\n📄 Testing default colors still work:');
  print('colors.red500: ${colors.red500}');
  print('colors.blue500: ${colors.blue500}');
  
  print('\n📄 Testing all colors map:');
  print('colors.allColors["brand-primary"]: ${colors.allColors["brand-primary"]}');
  print('colors.allColors["red500"]: ${colors.allColors["red500"]}');
  
  // Test spacing
  final spacing = FlySpacing.defaultSpacing;
  
  print('\n📄 Testing spacing dot notation:');
  print('spacing.xs: ${spacing.xs}');
  print('spacing.sm: ${spacing.sm}');
  print('spacing.xl2: ${spacing.xl2}');
  
  print('\n📄 Testing spacing array lookup:');
  print('spacing["xs"]: ${spacing["xs"]}');
  print('spacing["2xl"]: ${spacing["2xl"]}');
  
  print('\n📄 Testing default spacing still works:');
  print('spacing.base: ${spacing.base}');
  
  print('\n✅ All tests completed!');
}
