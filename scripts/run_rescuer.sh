#!/bin/bash
set -e
isoFile="./target/live-rescuer-amd64.hybrid.iso"

#$ qemu-system-x86_64 \
#                [machine opts] \
#                [cpu opts] \
#                [accelerator opts] \
#                [device opts] \
#                [backend opts] \
#                [interface opts] \
#                [boot opts]

machineOpts="-machine q35 -m 2G"
cpuOpts="-cpu host -smp 2"
acceleratorOpts="-accel hvf"
deviceOpts="-device virtio-rng-pci,rng=rng0"
backendOpts="-object rng-random,id=rng0,filename=/dev/urandom"
deviceOpts="$deviceOpts -device virtio-net,netdev=vmnic"
backendOpts="$backendOpts -netdev user,ipv6=off,id=vmnic"


deviceOpts="$deviceOpts -device virtio-scsi"

deviceOpts="$deviceOpts -device scsi-cd,drive=cddisk,bootindex=1"
backendOpts="$backendOpts -drive driver=raw,file=$isoFile,if=none,id=cddisk,media=cdrom"

deviceOpts="$deviceOpts -device scsi-hd,drive=diskA,bootindex=3"
backendOpts="$backendOpts -drive driver=qcow2,file=$1,if=none,id=diskA"

deviceOpts="$deviceOpts -device virtio-9p,fsdev=sharedfolder,mount_tag=guest-exch"
backendOpts="$backendOpts -fsdev local,id=sharedfolder,path=./target/guest-exch,security_model=mapped"

set -x
qemu-system-x86_64 \
	$interfaceOpts \
	$machineOpts \
	$cpuOpts \
	$acceleratorOpts \
	$deviceOpts \
	$backendOpts \

