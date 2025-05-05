#!/bin/bash
set -e

cpuOpts="-cpu qemu64 -smp 2"
machineOpts="-machine q35 -m 2G"

deviceOpts="-device virtio-rng-pci,rng=rng0,addr=1f.4"
backendOpts="-object rng-random,id=rng0,filename=/dev/urandom"

deviceOpts="$deviceOpts -device virtio-net,netdev=vmnic"
backendOpts="$backendOpts -netdev user,ipv6=off,id=vmnic"


#interfaceOpts="-nographic -serial"

set -x
qemu-system-x86_64 \
	$acceleratorOpts \
	$cpuOpts \
	$machineOpts \
	-kernel ./target/$1 \
	-initrd ./target/$2 \
	-append "tsc=unstable clocksource=hpet" \
	$interfaceOpts \
	$deviceOpts \
	$backendOpts \
	$interfaceOpts


#	-append "console=ttyS0" \
#	-append "earlyprintk=ttyS0 console=ttyS0" \
#	-append "tsc=unstable clocksource=hpet RAADBG=PROC,SYS,MDEV,MODULES,TESTS,SHELL" \
#interfaceOpts="-nographic"
#interfaceOpts="-serial mon:stdio"
