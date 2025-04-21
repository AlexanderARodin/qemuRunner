#!/bin/bash
set -e
set -x

machineOpts="-machine q35 -m 2G"
cpuOpts="-cpu host -smp 2"
acceleratorOpts="-accel hvf"
deviceOpts="-device virtio-rng-pci,rng=rng0,addr=1f.4"
backendOpts="-object rng-random,id=rng0,filename=/dev/urandom"

deviceOpts="$deviceOpts -device virtio-9p,fsdev=sharedfolder,mount_tag=guest-exch,addr=1f.5"
backendOpts="$backendOpts -fsdev local,id=sharedfolder,path=./XXX/guest-exch,security_model=mapped"
deviceOpts="$deviceOpts -device virtio-net,netdev=vmnic,addr=1f.6"
backendOpts="$backendOpts -netdev user,ipv6=off,id=vmnic"

#deviceOpts="$deviceOpts -device virtio-mouse-pci,addr=5"

deviceOpts="$deviceOpts -device virtio-scsi,addr=4"
deviceOpts="$deviceOpts -device scsi-cd,drive=cddisk"
backendOpts="$backendOpts -drive driver=raw,file=./workFiles/live-rescuer-amd64.hybrid.iso,if=none,id=cddisk,media=cdrom"
deviceOpts="$deviceOpts -device scsi-hd,drive=diskB"
backendOpts="$backendOpts -drive driver=qcow2,file=./workFiles/test.qcow2,if=none,id=diskB"

deviceOpts="$deviceOpts -device virtio-blk,drive=vHD,addr=2"
#deviceOpts="$deviceOpts -device scsi-hd,drive=vHD"
backendOpts="$backendOpts -blockdev node-name=vHD,driver=qcow2,file.driver=file,file.filename=./workFiles/test2.qcow2"

#interfaceOpts="-nographic -serial mon:stdio"

#qemu-system-x86_64 \
#                [machine opts] \
#                [cpu opts] \
#                [accelerator opts] \
#                [device opts] \
#                [backend opts] \
#                [interface opts] \
#                [boot opts]

