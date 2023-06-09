ifeq ($(RELEASE),1)
	FINALPACKAGE = 1
endif

ifeq ($(ROOTLESS),1)
	THEOS_PACKAGE_SCHEME=rootless
endif

export ARCHS = arm64 arm64e

export TARGET := iphone:clang:latest:7.0

SDK_PATH = $(THEOS)/sdks/iPhoneOS14.5.sdk/
export SYSROOT = $(SDK_PATH)

INSTALL_TARGET_PROCESSES = LINE

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = K2ge3
K2ge3_FILES = Tweak.xm
K2ge3_CFLAGS = -fobjc-arc
K2ge3_FRAMEWORKS = UIKit Foundation

SUBPROJECTS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

include $(THEOS_MAKE_PATH)/aggregate.mk
