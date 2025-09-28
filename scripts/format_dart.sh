#!/bin/bash

# Format all Dart files in the project
echo "Formatting Dart files..."

# Format lib directory
echo "Formatting lib/ directory..."
dart format lib/

# Format example directory
echo "Formatting example/ directory..."
dart format example/lib/

# Format test directory
echo "Formatting test/ directory..."
dart format test/

# Format bin directory
echo "Formatting bin/ directory..."
dart format bin/

echo "Dart formatting complete!"
