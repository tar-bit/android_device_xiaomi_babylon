#
# Copyright (C) 2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8550-common
$(call inherit-product, device/xiaomi/sm8550-common/common.mk)

# Get non-open-source specific aspects
$(call inherit-product, vendor/xiaomi/babylon/babylon-vendor.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)


# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.babylon.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.babylon.rc \


kernelsource := false

ifneq ($(kernelsource), true)

DEVICE_PATH := device/xiaomi/babylon
KERNEL_PATH := device/xiaomi/babylon-kernel


# Kernel
BOARD_KERNEL_PAGESIZE   := 4096
BOARD_KERNEL_BASE       := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image

BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_KERNEL_CMDLINE := \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    disable_dma32=on \
    loop.max_part=7 \
    msm_rtb.filter=0x237 \
    pcie_ports=compat \
    service_locator.enable=1 \
    rcu_nocbs=all \
    rcutree.enable_rcu_lazy=1 \
    swinfo.fingerprint=$(LINEAGE_VERSION) \
    mtdoops.fingerprint=$(LINEAGE_VERSION)

BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true


TARGET_NO_KERNEL_OVERRIDE := true
TARGET_KERNEL_SOURCE := device/xiaomi/babylon-kernel/kernel-headers
PRODUCT_COPY_FILES += \
	$(KERNEL_PATH)/kernel:kernel
	
	
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/system_dlkm/modules.load))

BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/vendor_ramdisk/modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(KERNEL_PATH)/vendor_ramdisk/, $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/vendor_ramdisk/modules.blocklist

#BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/vendor_ramdisk/modules.load.recovery))
#RECOVERY_MODULES := $(addprefix $(KERNEL_PATH)/vendor_ramdisk/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

#BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(sort $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES) $(RECOVERY_MODULES))

BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/vendor_dlkm/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(addprefix $(KERNEL_PATH)/vendor_dlkm/, $(BOARD_VENDOR_KERNEL_MODULES_LOAD))

BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb

endif


# Euicc
PRODUCT_PACKAGES += \
    XiaomiEuicc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# Overlay
PRODUCT_PACKAGES += \
    ApertureResBabylon \
    SystemUIOverlayBabylon \
    SettingsOverlayBabylon \
    sqlite3 \
    FrameworksResBabylon \
   # FoldBridge
    
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml


#PRODUCT_COPY_FILES += \
#    vendor/xiaomi/babylon/proprietary/odm/lib/sqlite3.so:$(TARGET_COPY_OUT_VENDOR)/lib/sqlite3.so \
#    vendor/xiaomi/babylon/proprietary/odm/lib64/sqlite3.so:$(TARGET_COPY_OUT_VENDOR)/lib64/sqlite3.so

# Hinge angle sensor
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.hinge_angle.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_cape/android.hardware.sensor.hinge_angle.xml


# Display configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/display_id_4630947024259405955.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/displayconfig/display_id_4630947024259405955.xml \
    $(LOCAL_PATH)/configs/display/display_id_4630947024259405956.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/displayconfig/display_id_4630947024259405956.xml
    
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/configs/fold/sns_fold_status.json:$(TARGET_COPY_OUT_PRODUCT)/etc/sensors/config/sns_fold_status.json \


# DPM
PRODUCT_PACKAGES += \
    libhidlbase_shim \
    
    
PRODUCT_PACKAGES += \
    libgralloc.system.qti \
    libdisplayconfig.system.qti \
    vendor.qti.hardware.display.composer3-V1-ndk \
    vendor.qti.hardware.display.config-V11-ndk \
    libsurfaceflinger \
    libjpeg-hyper \
    
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.config-V1-ndk \
    vendor.qti.hardware.display.config-V2-ndk \
    vendor.qti.hardware.display.config-V3-ndk \
    vendor.qti.hardware.display.config-V4-ndk \
    vendor.qti.hardware.display.config-V5-ndk \
    vendor.qti.hardware.display.config-V6-ndk \
    vendor.qti.hardware.display.config-V7-ndk \
    vendor.qti.hardware.display.config-V8-ndk \
    vendor.qti.hardware.display.config-V9-ndk \
    vendor.qti.hardware.display.config-V10-ndk \
    vendor.qti.hardware.display.config-V12-ndk \
    vendor.qti.hardware.display.config-V1-ndk.vendor \
    vendor.qti.hardware.display.config-V2-ndk.vendor \
    vendor.qti.hardware.display.config-V3-ndk.vendor \
    vendor.qti.hardware.display.config-V4-ndk.vendor \
    vendor.qti.hardware.display.config-V5-ndk.vendor \
    vendor.qti.hardware.display.config-V6-ndk.vendor \
    vendor.qti.hardware.display.config-V7-ndk.vendor \
    vendor.qti.hardware.display.config-V8-ndk.vendor \
    vendor.qti.hardware.display.config-V9-ndk.vendor \
    vendor.qti.hardware.display.config-V10-ndk.vendor \
    vendor.qti.hardware.display.config-V11-ndk.vendor \
    
    
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.demura-V1-ndk.vendor \
    vendor.qti.hardware.display.mapper@1.0.vendor \
    vendor.qti.hardware.display.mapper@1.1.vendor \
    vendor.qti.hardware.display.mapper@2.0.vendor \
    vendor.qti.hardware.display.mapper@3.0.vendor \
    vendor.qti.hardware.display.mapper@4.0.vendor \
    vendor.qti.hardware.display.mapperextensions@1.0.vendor \
    vendor.qti.hardware.display.mapperextensions@1.1.vendor \
    vendor.qti.hardware.display.mapperextensions@1.2.vendor \
    vendor.qti.hardware.display.mapperextensions@1.3.vendor \
    

PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.composer@1.0 \
    vendor.qti.hardware.display.composer@2.0 \
    vendor.qti.hardware.display.composer@3.0 \
    vendor.qti.hardware.display.composer@3.1 \
    vendor.qti.hardware.display.composer@1.0.vendor \
    vendor.qti.hardware.display.composer@2.0.vendor \
    vendor.qti.hardware.display.composer@3.0.vendor \
    vendor.qti.hardware.display.composer@3.1.vendor \

    
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.allocator@1.0.vendor \
    vendor.qti.hardware.display.allocator@3.0.vendor \
    vendor.qti.hardware.display.allocator@4.0.vendor \

PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1 \
    android.hardware.graphics.composer@2.2 \
    android.hardware.graphics.composer@2.3 \
    android.hardware.graphics.composer@2.4 \
    android.hardware.graphics.composer@2.1.vendor \
    android.hardware.graphics.composer@2.2.vendor \
    android.hardware.graphics.composer@2.3.vendor \
    android.hardware.graphics.composer@2.4.vendor \
    android.hardware.graphics.composer3-V3-ndk \

#android.hardware.graphics.composer@2.2::IComposerClient

PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@2.0 \
    android.hardware.graphics.mapper@2.1 \
    android.hardware.graphics.mapper@3.0 \
    android.hardware.graphics.mapper@4.0 \
    
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0 \
    android.hardware.graphics.allocator@3.0 \
    android.hardware.graphics.allocator@4.0 \
    android.hardware.graphics.allocator-V2-ndk \
    
    
PRODUCT_PACKAGES += \
    android.hardware.graphics.common@1.0 \
    android.hardware.graphics.common@1.1 \
    android.hardware.graphics.common@1.2 \
    android.hardware.graphics.common-V5-ndk

PRODUCT_PACKAGES += \
    android.hardware.graphics.bufferqueue@1.0 \
    android.hardware.graphics.bufferqueue@2.0 \


PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.demura@2.0.vendor \


PRODUCT_PACKAGES += \
    vendor.display.config@1.0 \
    vendor.display.config@1.1 \
    vendor.display.config@1.2 \
    vendor.display.config@1.3 \
    vendor.display.config@1.4 \
    vendor.display.config@1.5 \
    vendor.display.config@1.6 \
    vendor.display.config@1.7 \
    vendor.display.config@1.8 \
    vendor.display.config@1.9 \
    vendor.display.config@2.0 \
    vendor.display.config@1.10 \
    vendor.display.config@1.11 \
    vendor.display.config@1.0.vendor \
    vendor.display.config@1.1.vendor \
    vendor.display.config@1.2.vendor \
    vendor.display.config@1.3.vendor \
    vendor.display.config@1.4.vendor \
    vendor.display.config@1.5.vendor \
    vendor.display.config@1.6.vendor \
    vendor.display.config@1.7.vendor \
    vendor.display.config@1.8.vendor \
    vendor.display.config@1.9.vendor \
    vendor.display.config@2.0.vendor \
    vendor.display.config@1.10.vendor \
    vendor.display.config@1.11.vendor \
    


PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.displayfeature@1.0 \
    vendor.xiaomi.hardware.displayfeature@1.0.vendor \
#    vendor.xiaomi.hardware.displayfeature_aidl-V2-ndk \
#    vendor.xiaomi.hardware.displayfeature@1.0-impl \
#    vendor.xiaomi.hardware.display.mihwcextension-V1-ndk

PRODUCT_PACKAGES += \
    android.frameworks.schedulerservice@1.0 \
    android.frameworks.sensorservice@1.0 \
    android.frameworks.sensorservice-V1-ndk \
    android.hardware.common.fmq-V1-ndk \
    android.hardware.common-V2-ndk \
    android.hardware.common-V2-ndk_platform \
    

    
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/configs/vintf/device_framework_matrix.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml
    
    
    
    
# Dolby
#PRODUCT_PACKAGES += \
#    XiaomiDolby

# Sensors
PRODUCT_PACKAGES += \
    sensors.xiaomi.v2

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/hals.conf:$(TARGET_COPY_OUT_ODM)/etc/sensors/hals.conf
    
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/display_layout_configuration.xml:vendor/etc/displayconfig/display_layout_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/privapp-permissions-com.android.foldbridge.xml:system/etc/permissions/privapp-permissions-com.android.foldbridge.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/fold/odm/device_state_configuration.xml:odm/etc/device_state_configuration.xml

# PowerShare
#PRODUCT_PACKAGES += \
#    vendor.lineage.powershare@1.0-service.default

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
