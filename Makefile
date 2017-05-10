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

define KernelPackage/mtk_aes
  SUBMENU:=Other modules
  TITLE:=Driver for Mediatek MT7628AN AES Engine
  AUTOLOAD:=$(call Autoload,81,mtk_aes)
  FILES:=$(PKG_BUILD_DIR)/mtk_aes.ko
  KCONFIG:=
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH="$(LINUX_KARCH)" \
		SUBDIRS="$(PKG_BUILD_DIR)" \
		EXTRA_CFLAGS="$(BUILDFLAGS)" \
		modules
endef

$(eval $(call KernelPackage,mtk_aes))
