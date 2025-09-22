# Flywind Example App

This directory contains an example Flutter app that demonstrates how to use the Flywind library.

## Running the Example

### Quick Setup (Recommended)

1. Navigate to this directory:
   ```bash
   cd example
   ```

2. Initialize Flywind configuration:
   ```bash
   dart run flywind:fly init
   ```
   This will copy the YAML configuration and create the necessary folder structure.

3. Generate the config folder:
   ```bash
   dart run flywind:fly generate
   ```
   This will generate the configuration files and tokens.

4. Run the app:
   ```bash
   flutter run
   ```

### Manual Setup

1. Navigate to this directory:
   ```bash
   cd example
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Initialize Flywind:
   ```bash
   dart run flywind:fly init
   ```

4. Generate configuration:
   ```bash
   dart run flywind:fly generate
   ```

5. Run the app:
   ```bash
   flutter run -d macos
   ```

## What's Included

- A complete Flutter app demonstrating Flywind components
- Platform-specific configurations for Android, iOS, Web, macOS, Linux, and Windows
- Example usage of various Flywind utilities and components

## Configuration

The example app uses the Flywind configuration files:
- `flywind.yaml` - Main configuration

You can modify these files to see how different configurations affect the generated code.
