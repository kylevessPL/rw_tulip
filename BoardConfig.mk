DEVICE_TREE := device/xiaomi/tulip

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a73

TARGET_USES_64_BIT_BINDER := true

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm660
TARGET_NO_BOOTLOADER := true

# Encryption
#TW_CRYPTO_USE_SYSTEM_VOLD := true
#TW_CRYPTO_USE_SYSTEM_VOLD := qseecomd
#TARGET_KEYMASTER_WAIT_FOR_QSEE := true
TW_INCLUDE_CRYPTO := true
PLATFORM_SECURITY_PATCH := 2029-10-01
#TARGET_PROVIDES_KEYMASTER := true
# Fix userdata decryption
TW_CRYPTO_USE_SYSTEM_VOLD := \
    qseecomd \
    servicemanager \
    hwservicemanager \
    keymaster-3-0

TW_CRYPTO_SYSTEM_VOLD_MOUNT := vendor

# Keymaster 3
TARGET_HW_DISK_ENCRYPTION := true
#PLATFORM_VERSION := 8.1.0
#PLATFORM_SECURITY_PATCH := 2018-12-01


# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 earlycon=msm_serial_dm,0xc170000
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 sched_enable_hmp=1 sched_enable_power_aware=1
BOARD_KERNEL_CMDLINE += service_locator.enable=1 swiotlb=1 androidboot.configfs=true
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a800000.dwc3
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_PREBUILT_KERNEL := $(DEVICE_TREE)/Image.gz-dtb

# Platform
TARGET_BOARD_PLATFORM := sdm660
TARGET_BOARD_PLATFORM_GPU := qcom-adreno509

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # echo $(($BOARD_KERNEL_PAGESIZE * 64))
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 55155080704
BOARD_VENDORIMAGE_PARTITION_SIZE := 2147483648

# Support EXT4 filesystem
TARGET_USERIMAGES_USE_EXT4 := true

# Support F2FS filesystem
TARGET_USERIMAGES_USE_F2FS := true

#Specify large fs
BOARD_HAS_LARGE_FILESYSTEM := true

# Vendor stuff
TARGET_COPY_OUT_VENDOR := vendor

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Specify color scheme
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

#Fix time on boot
TARGET_RECOVERY_QCOM_RTC_FIX := true

#Let the recovery know that device supports datamedia
RECOVERY_SDCARD_ON_DATA := true

#Specify path to the lcd brightness driver
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"

#Exclude the default recovery usb init 
TW_EXCLUDE_DEFAULT_USB_INIT := true

#Support Asian regions
TW_EXTRA_LANGUAGES := true

#Add support for NTFS filesystem
TW_INCLUDE_NTFS_3G := true

# Disable Mouse Cursor
TW_INPUT_BLACKLIST := "hbtp_vm"

# Max brightness specified by the lcd driver
TW_MAX_BRIGHTNESS := 4095

# 2048 seems to be optimal
TW_DEFAULT_BRIGHTNESS := 2048

#Force minui to blank a screen at init
TW_SCREEN_BLANK_ON_BOOT := true

#Ignore bootloader's wipe requests of /data
#TW_IGNORE_MISC_WIPE_DATA := true

# Partition Format
TARGET_RECOVERY_FSTAB := $(DEVICE_TREE)/recovery/root/etc/recovery.fstab

#Stock kernel seems to be using different one...
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

#Specify device tree author
TW_DEVICE_VERSION := tulip_geekon

# Vendor Init
TARGET_INIT_VENDOR_LIB := libinit_$(TARGET_DEVICE)

TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2280

#Specify the codename for OTA installations
TARGET_OTA_ASSERT_DEVICE := $(TARGET_DEVICE)


# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true

#Use new ion heap
TW_NEW_ION_HEAP := true

#TW_USE_TOOLBOX := true

# TWRP Debug Flags
#TWRP_EVENT_LOGGING := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
#TARGET_RECOVERY_DEVICE_MODULES += debuggerd
#TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(OUT)/system/bin/debuggerd
#TARGET_RECOVERY_DEVICE_MODULES += strace
#TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(OUT)/system/xbin/strace
#TW_CRYPTO_SYSTEM_VOLD_DEBUG := true
#TW_CRYPTO_SYSTEM_VOLD_DEBUG := /system/bin/strace
#TARGET_RECOVERY_DEVICE_MODULES += twrpdec
#TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(OUT)/recovery/root/sbin/twrpdec
#TARGET_RECOVERY_DEVICE_MODULES += dump_footer
