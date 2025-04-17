#
# Copyright (C) 2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#
BUILD_BROKEN_DUP_RULES := true

DEVICE_PATH := device/xiaomi/babylon

# Inherit from sm8550-common
include device/xiaomi/sm8550-common/BoardConfigCommon.mk

include vendor/xiaomi/babylon/BoardConfigVendor.mk

# Sensors
TARGET_SENSOR_NOTIFIER_EXT := //device/xiaomi/babylon:libsensor-notifier-ext-fold

DEVICE_PATH := device/xiaomi/babylon

# Display
TARGET_SCREEN_DENSITY := 440

# Kernel	
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOOT_KERNEL_MODULES += \
	cs35l41_dlkm.ko \
	fts_touch_spi_pri.ko \
	fts_touch_spi_sec.ko \

BOARD_VENDOR_KERNEL_MODULES_LOAD += \
	cs35l41_dlkm.ko \
	fts_touch_spi_pri.ko \
	fts_touch_spi_sec.ko \

# OTA
TARGET_OTA_ASSERT_DEVICE := babylon

# Recovery
TARGET_RECOVERY_DEFAULT_ROTATION := ROTATION_LEFT

# Powershare
TARGET_POWERSHARE_PATH := /sys/class/qcom-battery/reverse_chg_mode

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/properties/system.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/properties/vendor.prop

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

include vendor/xiaomi/babylon/BoardConfigVendor.mk
