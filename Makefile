.PHONY: clean get analyze format build-runner watch test build-ios build-android run dev-setup rebuild check create-podspec help

# Clean build files
clean:
	@echo "Cleaning..."
	@rm -rf build
	@rm -rf .dart_tool
	@fvm flutter clean

# Get packages
get:
	@echo "Getting packages..."
	@fvm flutter pub get

# Analyze code
analyze:
	@echo "Analyzing..."
	@fvm flutter analyze

# Format code
format:
	@echo "Formatting..."
	@dart format lib
	@dart format test
	@dart fix --apply

# Generate files
build-runner:
	@echo "Generating files..."
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

# Watch files and generate
watch:
	@echo "Watching files..."
	@fvm flutter pub run build_runner watch --delete-conflicting-outputs

# Run tests
test:
	@echo "Running tests..."
	@fvm flutter test

# Build iOS
build-ios:
	@echo "Building iOS..."
	@cd ios && pod install
	@cd ..
	@make create-podspec
	@fvm flutter build ios

# Build Android
build-android:
	@echo "Building Android..."
	@fvm flutter build apk

# Run app
run:
	@echo "Running app..."
	@fvm flutter run

# All-in-one development setup
dev-setup: clean get build-runner

# Run all checks
check: format analyze test
# Rebuild everything
rebuild: clean get build-runner build-ios build-android

# Unity関連の変数
UNITY_LIBRARY_PATH = ios/UnityLibrary
PODSPEC_PATH = $(UNITY_LIBRARY_PATH)/UnityFramework.podspec
TEMPLATE_PATH = scripts/templates/UnityFramework.podspec.template

# Podspecファイルの作成
create-podspec:
	@echo "Creating UnityFramework.podspec..."
	@mkdir -p $(UNITY_LIBRARY_PATH)
	@cp $(TEMPLATE_PATH) $(PODSPEC_PATH)
	@echo "UnityFramework.podspec created successfully"

# Help
help:
	@echo "Available commands:"
	@echo "  make dev-setup   - 開発環境のセットアップ(clean, get, build-runner)"
	@echo "  make get         - パッケージの取得"
	@echo "  make analyze     - コードの分析"
	@echo "  make format      - コードのフォーマット"
	@echo "  make build-runner - コードファイルの生成"
	@echo "  make watch       - コードファイルの監視と生成"
	@echo "  make check       - すべてのチェックを実行 (format, analyze, test)"
	@echo "  make test        - テストの実行"
	@echo "  make build-ios   - iOSアプリのビルド"
	@echo "  make build-android - Androidアプリのビルド"
	@echo "  make run         - アプリの実行"
	@echo "  make rebuild     - すべてのビルド"
	@echo "  make clean       - ビルドファイルのクリーンアップ"
	@echo "  make create-podspec - UnityFramework.podspecの作成"
