LOCAL_PATH := $(call my-dir)


include $(CLEAR_VARS)
LOCAL_PACKAGE_NAME := FoldBridge
LOCAL_SRC_FILES := $(call all-java-files-under, src)
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
LOCAL_USE_AAPT2 := true
LOCAL_MODULE_TAGS := optional
LOCAL_PRIVATE_PLATFORM_APIS := true
LOCAL_AAPT_FLAGS := --auto-add-overlay
LOCAL_PROGUARD_ENABLED := disabled

include $(BUILD_PACKAGE)

