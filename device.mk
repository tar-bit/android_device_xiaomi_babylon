#
# Copyright (C) 2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8550-common
$(call inherit-product, device/xiaomi/sm8550-common/common.mk)

# Get non-open-source specific aspects
$(call inherit-product, vendor/xiaomi/babylon/babylon-vendor.mk)

# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.babylon.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.babylon.rc \




ifneq ($(kernelsource), true)

DEVICE_PATH := device/xiaomi/babylon
KERNEL_PATH := device/xiaomi/babylon-kernel
kernelsource := false

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
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/vendor_ramdisk/modules.blocklist

BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/vendor_ramdisk/modules.load.recovery))
RECOVERY_MODULES := $(addprefix $(KERNEL_PATH)/vendor_ramdisk/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(sort $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES) $(RECOVERY_MODULES))

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
    FrameworkResOverlayBabylon \
    SystemUIOverlayBabylon \
    SettingsOverlayBabylon \
    sqlite3
    

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



# Sensors
PRODUCT_PACKAGES += \
    sensors.xiaomi.v2

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/hals.conf:$(TARGET_COPY_OUT_ODM)/etc/sensors/hals.conf
    
# Sensors
TARGET_SENSOR_NOTIFIER_EXT := //device/xiaomi/babylon:libsensor-notifier-ext-fold

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare@1.0-service.default

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
