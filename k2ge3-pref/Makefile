TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = k2ge3-pref

k2ge3-pref_FILES = XXXRootListController.m
k2ge3-pref_FRAMEWORKS = UIKit Foundation
k2ge3-pref_PRIVATE_FRAMEWORKS = Preferences
k2ge3-pref_INSTALL_PATH = /Library/PreferenceBundles
k2ge3-pref_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
