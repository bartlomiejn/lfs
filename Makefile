SRC_DIR ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

LFS ?= /mnt/lfs
LFS_PART ?= /dev/sdb1
SWAP_PART ?= /dev/sdb2

LFS_MNT := $(grep $(shell df -h | grep $(LFS_PART))
SWAPON := $(shell swapon -s | grep $(SWAP_PART))

$(LFS):
	mkdir -pv $(LFS)

lfs: $(LFS)
	ifeq ($(LFS_MNT),)
		mount -v -t ext4 $(LFS_PART) $(LFS)
	endif
	ifeq ($(SWAPON),)
		/sbin/swapon -v $(SWAP_PART)
	endif