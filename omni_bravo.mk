# Call this first so apn list is actually copied
$(call inherit-product, vendor/omni/config/gsm.mk)

$(call inherit-product, device/htc/bravo/full_bravo.mk)

# Inherit some common stuff.
$(call inherit-product, vendor/omni/config/common_full_phone.mk)

#
# Setup device specific product configuration.
#
PRODUCT_NAME    := omni_bravo
PRODUCT_BRAND   := htc_wwe
PRODUCT_DEVICE  := bravo
PRODUCT_MODEL   := HTC Desire
PRODUCT_MANUFACTURER := HTC
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_bravo BUILD_FINGERPRINT=htc_wwe/htc_bravo/bravo:2.3.3/GRI40/96875.1:user/release-keys TARGET_BUILD_TYPE=userdebug BUILD_VERSION_TAGS=release-keys PRIVATE_BUILD_DESC="3.14.405.1 CL96875 release-keys"
PRODUCT_RELEASE_NAME := bravo

# Bootanimation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480

# Use low fps boot animation for bravo
USE_LOWFPS_BOOTANI := true
