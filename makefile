JAVA_BINARY := /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin

DEBUG_KEY_NAME := debugkey.jks
DEBUG_KEY_ALIAS := androiddebugkey
RELEASE_KEY_NAME := releasekey.jks
RELEASE_KEY_ALIAS := androidreleasekey

KEY_DIRECTORY := ~/Documents/keys/android
DEBUG_KEY_FILE_PATH := $(KEY_DIRECTORY)/$(DEBUG_KEY_NAME)
RELEASE_KEY_FILE_PATH := $(KEY_DIRECTORY)/$(RELEASE_KEY_NAME)

KEYTOOL_GENERATE := $(JAVA_BINARY)/keytool -genkey -v -keyalg RSA -keysize 2048 -validity 10000 -alias $(1) -keystore $(2)
KEYTOOL_GET_HASH := $(JAVA_BINARY)/keytool -exportcert -alias $(1) -keystore $(2) | openssl sha1 -binary | openssl base64
KEYTOOL_GET_FINGERPRINT := $(JAVA_BINARY)/keytool -keystore $(1) -list -v

key := debug

keytool-generate:
ifeq ($(key), release) 
	$(call KEYTOOL_GENERATE, RELEASE_KEY_ALIAS, RELEASE_KEY_FILE_PATH)
else
	$(call KEYTOOL_GENERATE, DEBUG_KEY_ALIAS, DEBUG_KEY_FILE_PATH)
endif

keytool-get-hash:
ifeq ($(key), release) 
	$(call KEYTOOL_GET_HASH, RELEASE_KEY_ALIAS, RELEASE_KEY_FILE_PATH)
else
	$(call KEYTOOL_GET_HASH, DEBUG_KEY_ALIAS, DEBUG_KEY_FILE_PATH)
endif

keytool-get-fingerprint:
ifeq ($(key), release) 
	$(call KEYTOOL_GET_FINGERPRINT, RELEASE_KEY_FILE_PATH)
else
	$(call KEYTOOL_GET_FINGERPRINT, DEBUG_KEY_FILE_PATH)
endif

flutter-clean:
	flutter pub cache repair
	flutter clean

flutter-upgrade:
	flutter pub upgrade

flutter-outdated:
	flutter pub outdated

flutter-build-apk:
	flutter build apk --target-platform=android-arm64

run-build-runner:
	flutter pub run build_runner watch --delete-conflicting-outputs

run-import-sorter:
	flutter pub run import_sorter:main
