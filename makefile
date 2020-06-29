JAVA_BINARY := /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin

KEY_OUTPUT_DIRECTORY := ~/Documents/keys/android
RELEASE_KEY_NAME := releasekey.jks
RELEASE_KEY_ALIAS := androidreleasekey
DEBUG_KEY_NAME := debugkey.jks
DEBUG_KEY_ALIAS := androiddebugkey

build-runner:
	flutter pub run build_runner watch --delete-conflicting-outputs

generate-debug-key:
	$(JAVA_BINARY)/keytool -genkey -v -keystore $(KEY_OUTPUT_DIRECTORY)/$(DEBUG_KEY_NAME) -keyalg RSA -keysize 2048 -validity 10000 -alias $(DEBUG_KEY_ALIAS)

get-debug-key-fingerprint:
	$(JAVA_BINARY)/keytool -keystore $(KEY_OUTPUT_DIRECTORY)/$(DEBUG_KEY_NAME)  -list -v

generate-release-key:
	$(JAVA_BINARY)/keytool -genkey -v -keystore $(KEY_OUTPUT_DIRECTORY)/$(RELEASE_KEY_NAME) -keyalg RSA -keysize 2048 -validity 10000 -alias $(DEBUG_KEY_ALIAS)

get-release-key-fingerprint:
	$(JAVA_BINARY)/keytool -keystore $(KEY_OUTPUT_DIRECTORY)/$(RELEASE_KEY_NAME)  -list -v
