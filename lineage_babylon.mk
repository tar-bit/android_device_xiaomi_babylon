#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Configure core_64_bit.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit common LineageOS configurations
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit device configurations
$(call inherit-product, device/xiaomi/babylon/device.mk)

# Inherit from Gapps
#$(call inherit-product-if-exists, vendor/gapps/arm64/arm64-vendor.mk)

## Device identifier
PRODUCT_DEVICE := babylon
PRODUCT_NAME := lineage_babylon
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 2211133G
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_SYSTEM_NAME := 2211133G
PRODUCT_SYSTEM_DEVICE := 2211133G

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc=$(call normalize-path-list, "babylon_global-user 15 TKQ1.221114.001 V816.0.5.0.VMVCNXM release-keys")

BUILD_FINGERPRINT := Xiaomi/babylon_global/babylon:15/TKQ1.221114.001/V816.0.5.0.VMVCNXM:user/release-keys

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
