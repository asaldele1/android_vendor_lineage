LINEAGE_TARGET_FB_PACKAGE := $(PRODUCT_OUT)/LunarOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-Fastboot-$(shell date +%Y%m%d)-$(LINEAGE_BUILD).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: fb_package
fb_package: $(BUILT_TARGET_FILES_PACKAGE) $(IMG_FROM_TARGET_FILES_EXTENDED)
	$(call pretty,"Package fastboot: $(LINEAGE_TARGET_FB_PACKAGE)")
	PATH=$(INTERNAL_USERIMAGES_BINARY_PATHS):$(dir $(ZIP2ZIP)):$$PATH \
	    $(IMG_FROM_TARGET_FILES_EXTENDED) \
	        --additional_zip $(PRODUCT_FASTBOOT_TEMPLATE_ZIP) \
	        --exclude_android_info \
	        --images_path $(PRODUCT_FASTBOOT_IMAGES_PATH) \
	        $(BUILT_TARGET_FILES_PACKAGE) $(LINEAGE_TARGET_FB_PACKAGE)
	$(hide) $(SHA256) $(LINEAGE_TARGET_FB_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_FB_PACKAGE).sha256sum
	$(hide) rm -rf $(call intermediates-dir-for,PACKAGING,target_files)
	@echo "Package Complete: $(LINEAGE_TARGET_FB_PACKAGE)" >&2
