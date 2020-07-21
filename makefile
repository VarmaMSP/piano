JAVA_BINARY := /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin
KEY_OUTPUT_DIRECTORY := ~/Documents/keys/android
DEBUG_KEY_NAME := debugkey.jks
DEBUG_KEY_ALIAS := androiddebugkey
RELEASE_KEY_NAME := releasekey.jks
RELEASE_KEY_ALIAS := androidreleasekey

build-runner:
	flutter pub run build_runner watch --delete-conflicting-outputs

generate-debug-key:
	$(JAVA_BINARY)/keytool -genkey -v -keystore $(KEY_OUTPUT_DIRECTORY)/$(DEBUG_KEY_NAME) -keyalg RSA -keysize 2048 -validity 10000 -alias $(DEBUG_KEY_ALIAS)

get-debug-key-fingerprint:
	$(JAVA_BINARY)/keytool -keystore $(KEY_OUTPUT_DIRECTORY)/$(DEBUG_KEY_NAME) -list -v

get-debug-key-hash:
	$(JAVA_BINARY)/keytool -exportcert -alias $(DEBUG_KEY_ALIAS) -keystore $(KEY_OUTPUT_DIRECTORY)/$(DEBUG_KEY_NAME) | openssl sha1 -binary | openssl base64

generate-release-key:
	$(JAVA_BINARY)/keytool -genkey -v -keystore $(KEY_OUTPUT_DIRECTORY)/$(RELEASE_KEY_NAME) -keyalg RSA -keysize 2048 -validity 10000 -alias $(RELEASE_KEY_ALIAS)

get-release-key-fingerprint:
	$(JAVA_BINARY)/keytool -keystore $(KEY_OUTPUT_DIRECTORY)/$(RELEASE_KEY_NAME)  -list -v

get-release-key-hash:
	$(JAVA_BINARY)/keytool -exportcert -alias $(RELEASE_KEY_ALIAS) -keystore $(KEY_OUTPUT_DIRECTORY)/$(RELEASE_KEY_NAME) | openssl sha1 -binary | openssl base64

build-release-apk:
	flutter build apk --target-platform=android-arm64

flutter-clean: 
	flutter clean

repair-cache:
	flutter pub cache repair
	flutter clean

upgrade-dependencies:
	flutter pub upgrade

outdated-dependencies:
	flutter pub outdated

sort-imports:
	flutter pub run import_sorter:main
