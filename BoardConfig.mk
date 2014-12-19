# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).

# Camera
USE_CAMERA_STUB := false
ifeq ($(USE_CAMERA_STUB),false)
BOARD_CAMERA_LIBRARIES := libcamera
endif

# inherit from the proprietary version
-include vendor/htc/bravo/BoardConfigVendor.mk
# inherit common defines for all qsd8k devices
include device/htc/qsd8k-common/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := bravo

BOARD_KERNEL_CMDLINE := no_console_suspend=1 msmsdcc_sdioirq=1 wire.search_count=5 androidboot.selinux=permissive androidboot.hardware=bravo
BOARD_KERNEL_BASE := 0x20000000
BOARD_KERNEL_NEW_PPPOX := true

TARGET_KERNEL_CONFIG    := bravo_defconfig
TARGET_RAMDISK_COMPRESSION := xz --check=crc32 --arm --lzma2=dict=1MiB

# to enable the GPS HAL
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := bravo

# AMSS version to use for GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 3200

# Pull all dictionaries
TARGET_USE_KEYBOARD := international

# Use legacy touchscreen
BOARD_USE_LEGACY_TOUCHSCREEN := true

# Hacks
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/class/android_usb/android0/f_mass_storage/lun0/file
TARGET_NO_NETD_AF_INET := true
BOARD_USE_LEGACY_TRACKPAD := true
BOARD_NO_WIFI_HAL := true
BOARD_HAVE_PRE_KITKAT_AUDIO_POLICY_BLOB := true

# Inform ART we have a single core
TARGET_CPU_SMP := false

# ART
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),userdebug)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif
DONT_DEXPREOPT_PREBUILTS := true
MALLOC_IMPL := dlmalloc

# Reduce font size
EXTENDED_FONT_FOOTPRINT := true

# Remove packages
REMOVE_PRODUCT_PACKAGES += Gallery2 Exchange2 LiveWallpapers Galaxy4
REMOVE_PRODUCT_PACKAGES += Email

# Recovery
TARGET_RECOVERY_FSTAB   := device/htc/bravo/fstab.bravo

# TWRP Flags
DEVICE_RESOLUTION := 480x800
BOARD_HAS_NO_REAL_SDCARD := true
TW_EXCLUDE_SU := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := true
TW_NO_SCREEN_BLANK := true
TW_USE_TOOLBOX := true

# # cat /proc/mtd
# dev:    size   erasesize  name
# mtd0: 000a0000 00020000 "misc"
# mtd1: 00500000 00020000 "recovery"
# mtd2: 00280000 00020000 "boot"
# mtd3: 0fa00000 00020000 "system"
# mtd4: 02800000 00020000 "cache"
# mtd5: 093a0000 00020000 "userdata"
BOARD_BOOTIMAGE_PARTITION_SIZE := 3433024 # 3.3M 
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 7000000 # 7M
BOARD_SYSTEMIMAGE_PARTITION_SIZE :=  1048576000 # 1000M
#BOARD_USERDATAIMAGE_PARTITION_SIZE := 1572864000 # 1500M
BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_USERIMAGES_USE_EXT4 := true

# SELinux
include device/qcom/sepolicy/sepolicy.mk

# Legacy ril (for CM)
LEGACY_RIL := true
BOARD_USES_LEGACY_RIL := true

# Legacy Patches
USE_SET_METADATA := false
BOARD_USES_LEGACY_MMAP := true
TARGET_QCOM_LEGACY_OMX := true
QCOM_NO_SECURE_PLAYBACK := true

# Kernel target toolchain
TARGET_GCC_VERSION_ARM := 4.7
