#
# Copyright (C) 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Dynamic Partitions
BOARD_USE_DYNAMIC_PARTITIONS := true

# A/B support
AB_OTA_UPDATER := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
	boot \
	dtbo \
	lk \
	logo \
	md1img \
	preloader \
	product \
	scp \
	spmfw \
	sspm \
	system \
	tee \
	vbmeta \
	vbmeta_system \
	vbmeta_vendor \
	vendor

# A/B support
PRODUCT_PACKAGES += \
	otapreopt_script \
	cppreopts.sh \
	update_engine \
	update_engine_sideload \
	update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_system=true \
	POSTINSTALL_PATH_system=system/bin/otapreopt_script \
	FILESYSTEM_TYPE_system=ext4 \
	POSTINSTALL_OPTIONAL_system=true

# API
PRODUCT_SHIPPING_API_LEVEL := 30

# Virtual A/B OTA
ENABLE_VIRTUAL_AB := true
$(call inherit-product, \
	$(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Boot control HAL
PRODUCT_PACKAGES += \
	android.hardware.boot@1.1-impl-recovery \
	android.hardware.boot@1.1-impl \
	android.hardware.boot@1.1-service \
	bootctrl.$(PRODUCT_PLATFORM).recovery

# Fastbootd
PRODUCT_PACKAGES += \
	android.hardware.fastboot@1.0-impl-mock \
	android.hardware.fastboot@1.0-impl-mock.recovery \
	fastbootd

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root) \
	$(LOCAL_PATH)/prebuilt/dtb.img:dtb.img

PRODUCT_PACKAGES_DEBUG += \
	update_engine_client

PRODUCT_PACKAGES += \
	android.hardware.health@2.1-impl \
	android.hardware.health@2.1-service \
	libhealthd.$(PRODUCT_PLATFORM)

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
	libkeymaster4 \
	libpuresoftkeymasterdevice

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
	$(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
	$(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH)
