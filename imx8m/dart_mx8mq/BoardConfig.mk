# -------@block_infrastructure-------
#
# Product-specific compile-time definitions.
#

include $(CONFIG_REPO_PATH)/imx8m/BoardConfigCommon.mk

# -------@block_common_config-------
#
# SoC-specific compile-time definitions.
#

BOARD_SOC_TYPE := IMX8MQ
BOARD_HAVE_VPU := true
BOARD_VPU_TYPE := hantro
HAVE_FSL_IMX_GPU2D := false
HAVE_FSL_IMX_GPU3D := true
HAVE_FSL_IMX_PXP := false
TARGET_USES_HWC2 := true
TARGET_HAVE_VULKAN := true

SOONG_CONFIG_IMXPLUGIN += \
                          BOARD_VPU_TYPE

SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_TYPE = IMX8MQ
SOONG_CONFIG_IMXPLUGIN_BOARD_HAVE_VPU = true
SOONG_CONFIG_IMXPLUGIN_BOARD_VPU_TYPE = hantro
SOONG_CONFIG_IMXPLUGIN_BOARD_VPU_ONLY = false
SOONG_CONFIG_IMXPLUGIN_PREBUILT_FSL_IMX_CODEC = true
SOONG_CONFIG_IMXPLUGIN_POWERSAVE = false

# -------@block_memory-------
USE_ION_ALLOCATOR := true
USE_GPU_ALLOCATOR := false

#IMX_DEVICE_PATH := device/variscite/imx8m/dart_mx8mq
# -------@block_storage-------
TARGET_USERIMAGES_USE_EXT4 := true

# use sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Support gpt
ifeq ($(TARGET_USE_DYNAMIC_PARTITIONS),true)
  BOARD_BPT_INPUT_FILES += $(CONFIG_REPO_PATH)/common/partition/device-partitions-13GB-ab_super.bpt
  ADDITION_BPT_PARTITION = partition-table-28GB:$(CONFIG_REPO_PATH)/common/partition/device-partitions-28GB-ab_super.bpt \
                           partition-table-dual:$(CONFIG_REPO_PATH)/common/partition/device-partitions-13GB-ab-dual-bootloader_super.bpt \
                           partition-table-28GB-dual:$(CONFIG_REPO_PATH)/common/partition/device-partitions-28GB-ab-dual-bootloader_super.bpt
else
  ifeq ($(IMX_NO_PRODUCT_PARTITION),true)
    BOARD_BPT_INPUT_FILES += $(CONFIG_REPO_PATH)/common/partition/device-partitions-13GB-ab-no-product.bpt
    ADDITION_BPT_PARTITION = partition-table-28GB:$(CONFIG_REPO_PATH)/common/partition/device-partitions-28GB-ab-no-product.bpt \
                             partition-table-dual:$(CONFIG_REPO_PATH)/common/partition/device-partitions-13GB-ab-dual-bootloader-no-product.bpt \
                             partition-table-28GB-dual:$(CONFIG_REPO_PATH)/common/partition/device-partitions-28GB-ab-dual-bootloader-no-product.bpt
  else
    BOARD_BPT_INPUT_FILES += $(CONFIG_REPO_PATH)/common/partition/device-partitions-13GB-ab.bpt
    ADDITION_BPT_PARTITION = partition-table-28GB:$(CONFIG_REPO_PATH)/common/partition/device-partitions-28GB-ab.bpt \
                             partition-table-dual:$(CONFIG_REPO_PATH)/common/partition/device-partitions-13GB-ab-dual-bootloader.bpt \
                             partition-table-28GB-dual:$(CONFIG_REPO_PATH)/common/partition/device-partitions-28GB-ab-dual-bootloader.bpt
  endif
endif

BOARD_PREBUILT_DTBOIMAGE := $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)/dtbo-imx8mq-var-dart-dt8mcustomboard-wifi-lvds.img

BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

# -------@block_security-------
ENABLE_CFI=false

BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA4096
# The testkey_rsa4096.pem is copied from external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_KEY_PATH := $(CONFIG_REPO_PATH)/common/security/testkey_rsa4096.pem

BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 2

# -------@block_treble-------
# Vendor Interface manifest and compatibility
DEVICE_MANIFEST_FILE := $(IMX_DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(IMX_DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(IMX_DEVICE_PATH)/device_framework_matrix.xml

# -------@block_wifi-------
BOARD_WLAN_DEVICE            := bcmdhd
WPA_SUPPLICANT_VERSION       := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211
BOARD_HOSTAPD_PRIVATE_LIB           := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_PRIVATE_LIB    := lib_driver_cmd_$(BOARD_WLAN_DEVICE)

# -------@block_sensor-------
BOARD_USE_SENSOR_FUSION := true

# -------@block_kernel_bootimg-------
BOARD_KERNEL_BASE := 0x40400000

ifeq ($(PRODUCT_IMX_DRM),true)
CMASIZE=736M
else
CMASIZE=1280M
endif

# Broadcom BT
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(IMX_DEVICE_PATH)/bluetooth
BOARD_CUSTOM_BT_CONFIG := $(BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR)/vnd_config.txt
BOARD_HAVE_BLUETOOTH_BCM := true

ifeq ($(TARGET_USE_DYNAMIC_PARTITIONS),true)
    TARGET_BOARD_DTS_CONFIG := \
	imx8mq-var-dart-dt8mcustomboard-wifi-lvds:imx8mq-var-dart-dt8mcustomboard-wifi-lvds.dtb \
	imx8mq-var-dart-dt8mcustomboard-wifi-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-wifi-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-wifi-hdmi:imx8mq-var-dart-dt8mcustomboard-wifi-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-sd-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-sd-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-sd-lvds:imx8mq-var-dart-dt8mcustomboard-sd-lvds.dtb \
	imx8mq-var-dart-dt8mcustomboard-sd-hdmi:imx8mq-var-dart-dt8mcustomboard-sd-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-sd-dp:imx8mq-var-dart-dt8mcustomboard-legacy-sd-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-sd-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-sd-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-sd-lvds-dp:imx8mq-var-dart-dt8mcustomboard-legacy-sd-lvds-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-sd-lvds:imx8mq-var-dart-dt8mcustomboard-legacy-sd-lvds.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-sd-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-sd-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-wifi-dp:imx8mq-var-dart-dt8mcustomboard-legacy-wifi-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-wifi-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-wifi-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-wifi-lvds-dp:imx8mq-var-dart-dt8mcustomboard-legacy-wifi-lvds-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-wifi-lvds:imx8mq-var-dart-dt8mcustomboard-legacy-wifi-lvds.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-wifi-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-wifi-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-dp:imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-lvds-dp:imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-lvds-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-lvds:imx8mq-var-dart-dt8mcustomboard-legacy-m4-sd-lvds.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-dp:imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-lvds-dp:imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-lvds-dp.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-lvds:imx8mq-var-dart-dt8mcustomboard-legacy-m4-wifi-lvds.dtb \
	imx8mq-var-dart-dt8mcustomboard-m4-sd-hdmi:imx8mq-var-dart-dt8mcustomboard-m4-sd-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-m4-sd-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-m4-sd-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-m4-sd-lvds:imx8mq-var-dart-dt8mcustomboard-m4-sd-lvds.dtb \
	imx8mq-var-dart-dt8mcustomboard-m4-wifi-hdmi:imx8mq-var-dart-dt8mcustomboard-m4-wifi-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-m4-wifi-lvds-hdmi:imx8mq-var-dart-dt8mcustomboard-m4-wifi-lvds-hdmi.dtb \
	imx8mq-var-dart-dt8mcustomboard-m4-wifi-lvds:imx8mq-var-dart-dt8mcustomboard-m4-wifi-lvds.dtb
endif

ALL_DEFAULT_INSTALLED_MODULES += $(BOARD_VENDOR_KERNEL_MODULES)

# -------@block_sepolicy-------
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    $(CONFIG_REPO_PATH)/imx8m/system_ext_pri_sepolicy

BOARD_SEPOLICY_DIRS := \
       $(CONFIG_REPO_PATH)/imx8m/sepolicy \
       $(IMX_DEVICE_PATH)/sepolicy

ifeq ($(PRODUCT_IMX_DRM),true)
BOARD_SEPOLICY_DIRS += \
       $(IMX_DEVICE_PATH)/sepolicy_drm
endif

