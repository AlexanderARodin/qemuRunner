#!/bin/bash
set -e
set -x


cpuOpts="-cpu qemu64 -smp 2"
machineOpts="-machine q35 -m 2G"

deviceOpts="-device virtio-rng-pci,rng=rng0,addr=1f.4"
backendOpts="-object rng-random,id=rng0,filename=/dev/urandom"

deviceOpts="$deviceOpts -device virtio-net,netdev=vmnic"
backendOpts="$backendOpts -netdev user,ipv6=off,id=vmnic"



qemu-system-x86_64 \
	$acceleratorOpts \
	$cpuOpts \
	$machineOpts \
	-kernel ./target/boot/$1 \
	-initrd ./target/boot/$2 \
	-append "tsc=unstable clocksource=hpet" \
	$interfaceOpts \
	$deviceOpts \
	$backendOpts \
	$interfaceOpts


#	-append "tsc=unstable clocksource=hpet RAADBG=PROC,SYS,MDEV,MODULES,TESTS,SHELL" \
#interfaceOpts="-nographic"
#interfaceOpts="-serial mon:stdio"
