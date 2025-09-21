#!/bin/bash

# Script to generate design token classes from JSON configurations
# Usage: ./scripts/generate_tokens.sh

echo "🎨 Generating FlyWind design tokens..."

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Check if tokens directory exists
if [ ! -d "tokens" ]; then
    echo "❌ Error: tokens/ directory not found"
    exit 1
fi

# Check if tool directory exists
if [ ! -d "tool" ]; then
    echo "❌ Error: tool/ directory not found"
    exit 1
fi

# Run the generator
echo "📝 Running token generator..."
dart tool/generate_tokens.dart

if [ $? -eq 0 ]; then
    echo "✅ Token generation completed successfully!"
    echo ""
    echo "Generated files:"
    echo "  - lib/tokens/border_radius.dart"
    echo "  - lib/tokens/spacing.dart"
    echo "  - lib/tokens/colors.dart"
    echo ""
    echo "💡 To modify tokens, edit the JSON files in tokens/ directory and run this script again."
else
    echo "❌ Token generation failed!"
    exit 1
fi
