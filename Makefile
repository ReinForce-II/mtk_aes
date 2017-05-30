#
# Copyright (C) 2006-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mtk_aes
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/mtk_aes/Default
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Cryptographic API modules
endef

define KernelPackage/mtk_aes
  $(call Package/mtk_aes/Default)
  SECTION:=kernel
  TITLE:=Kernel driver for HW AES ENGINE MT7628
  KCONFIG:= 
  FILES:=$(PKG_BUILD_DIR)/mtk_aes.ko
  MENU:=1
endef

define KernelPackage/mtk_aes/description
 Kernel module to enable HW Crypto Engine.
endef

define Package/kmod-mtk_aes/config
   menu "Configuration"

   config  CRYPTO_DEV_MTK_AES_INT
	bool "Use interrupts (vs Polling)"
        depends on PACKAGE_kmod-mtk_aes
	default y

   endmenu

endef

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
        CROSS_COMPILE="$(TARGET_CROSS)" \
        ARCH="$(LINUX_KARCH)" \
        SUBDIRS="$(PKG_BUILD_DIR)" \
        EXTRA_CFLAGS="$(BUILDFLAGS)" \
        modules
endef

$(eval $(call KernelPackage,mtk_aes))
