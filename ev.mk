# Pull all dictionaries (This makes sure it gets called)
TARGET_USE_KEYBOARD := international

# Release name
PRODUCT_RELEASE_NAME := HTC Desire

# Boot animation
BOOT_ANIMATION_SIZE := wvga

# Inherit some common evervolv stuff.
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/apns.mk)
$(call inherit-product, $(SRC_EVERVOLV_DIR)/config/common_full_phone.mk)
$(call inherit-product, device/htc/bravo/full_bravo.mk)

#
# Setup device specific product configuration.
#
PRODUCT_NAME    := ev_bravo
PRODUCT_BRAND   := htc_wwe
PRODUCT_DEVICE  := bravo
PRODUCT_MODEL   := HTC Desire
PRODUCT_MANUFACTURER := HTC
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_bravo BUILD_FINGERPRINT=htc_wwe/htc_bravo/bravo:2.3.3/GRI40/96875.1:user/release-keys TARGET_BUILD_TYPE=userdebug BUILD_VERSION_TAGS=release-keys PRIVATE_BUILD_DESC="3.14.405.1 CL96875 release-keys"

# Hot reboot
PRODUCT_PACKAGE_OVERLAYS += vendor/ev/overlay/hot_reboot
