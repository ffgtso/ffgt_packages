# Copyright (C) 2012 Nils Schneider <nils at nilsschneider.net>
# This is free software, licensed under the Apache 2.0 license.

include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-setup-mode-ffgt
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(GLUONDIR)/include/package.mk

define Package/gluon-setup-mode-ffgt
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Setup mode
  DEPENDS:=+gluon-core +uhttpd +dnsmasq +ip
  PROVIDES:=gluon-setup-mode
endef

define Package/gluon-setup-mode-ffgt/description
	DHCP-on-LAN to perform basic setup in a comfortable manner.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-setup-mode-ffgt/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,gluon-setup-mode-ffgt))
