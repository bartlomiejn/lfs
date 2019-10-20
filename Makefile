SRC_DIR ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

LFS ?= /mnt/lfs
LFS_PART ?= /dev/sdb1
SWAP_PART ?= /dev/sdb2

LFS_MNT := $(strip $(shell df -h | grep $(LFS_PART)))
SWAPON := $(strip $(shell swapon -s | grep $(SWAP_PART)))

$(LFS):
	mkdir -pv $(LFS)

lfs: $(LFS)

ifeq ($(LFS_MNT),)
	@echo LFS partition $(LFS_PART) is not mounted.
	mount -v -t ext4 $(LFS_PART) $(LFS)
else
	@echo $(LFS_PART) is mounted.
endif

ifeq ($(SWAPON),)
	@echo Swap partition $(SWAP_PART) is not on.
	/sbin/swapon -v $(SWAP_PART)
else
	@echo $(SWAP_PART) is used as swap partition.
endif