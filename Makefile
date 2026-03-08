.PHONY: generate generate-clean android android-debug android-release android-appbundle ios clean install format analyze test test-quick test-unit test-widget widgetbook-generate help

generate:
	@echo "Generating files with build_runner..."
	dart run build_runner build --delete-conflicting-outputs

widgetbook-generate:
	@echo "Generating widgetbook files..."
	cd widgetbook && dart run build_runner build --delete-conflicting-outputs

generate-clean:
	@echo "Cleaning generated files..."
	rm -rf .dart_tool/build
	find lib -name "*.g.dart" -type f -delete
	find widgetbook/lib -name "*.g.dart" -type f -delete

android: android-debug

android-debug:
	@echo "Building Android debug APK..."
	flutter build apk --debug

android-release:
	@echo "Building Android release APK..."
	flutter build apk --release

android-appbundle:
	@echo "Building Android app bundle for Play Store..."
	flutter build appbundle --release

ios:
	@echo "Building iOS app..."
	flutter build ios --release

clean:
	@echo "Cleaning Flutter build artifacts..."
	flutter clean
	@echo "Cleaning generated files..."
	rm -rf .dart_tool/build
	find lib -name "*.g.dart" -type f -delete
	find widgetbook/lib -name "*.g.dart" -type f -delete

install:
	@echo "Installing dependencies..."
	flutter pub get
	cd widgetbook && flutter pub get

format:
	@echo "Formatting Dart files..."
	dart format .

analyze:
	@echo "Analyzing Dart files..."
	flutter analyze

test:
	@echo "Running all tests..."
	flutter test

test-unit:
	@echo "Running unit tests only..."
	flutter test test/unit

test-widget:
	@echo "Running widget tests only..."
	flutter test test/widget

help:
	@echo "Available targets:"
	@echo ""
	@echo "Code Generation:"
	@echo "  make generate         - Generate files with build_runner"
	@echo "  make widgetbook-generate - Generate widgetbook files"
	@echo "  make generate-clean    - Clean generated files"
	@echo ""
	@echo "Build Targets:"
	@echo "  make android          - Build Android debug APK (alias for android-debug)"
	@echo "  make android-debug    - Build Android debug APK"
	@echo "  make android-release   - Build Android release APK"
	@echo "  make android-appbundle- Build Android app bundle (for Play Store)"
	@echo "  make ios              - Build iOS app"
	@echo ""
	@echo "Development:"
	@echo "  make install           - Install dependencies"
	@echo "  make format            - Format Dart files"
	@echo "  make analyze           - Analyze Dart files"
	@echo ""
	@echo "Testing:"
	@echo "  make test             - Run all tests"
	@echo "  make test-quick       - Run tests in quick mode (no pub get)"
	@echo "  make test-unit        - Run unit tests only"
	@echo "  make test-widget      - Run widget tests only"
	@echo ""
	@echo "Other:"
	@echo "  make clean            - Clean Flutter build and generated files"
	@echo "  make help             - Show this help message"
