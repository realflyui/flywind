#!/bin/bash

# Script to run the Flywind example app

echo "🚀 Running Flywind Example App..."
echo ""

# Check if we're in the right directory
if [ ! -d "example" ]; then
    echo "❌ Error: example directory not found. Please run this script from the flywind root directory."
    exit 1
fi

# Navigate to example directory
cd example

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Run the app
echo "🎯 Starting the example app..."
flutter run
