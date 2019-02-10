[root@controller vagrant]# pvdisplay 

  --- Physical volume ---
  PV Name               /dev/sda3
  VG Name               VolGroup00
  PV Size               <39.00 GiB / not usable 30.00 MiB
  Allocatable           yes (but full)
  PE Size               32.00 MiB
  Total PE              1247
  Free PE               0
  Allocated PE          1247
  PV UUID               vrrtbx-g480-HcJI-5wLn-4aOf-Olld-rC03AY
   
  "/dev/sdb" is a new physical volume of "10.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb
  VG Name               
  PV Size               10.00 GiB
  Allocatable           NO
  PE Size               0   
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               HHeDyT-Eag9-5eJW-TgNA-a9LS-oKq0-pq8TuT
   
[root@controller vagrant]# vgcreate vg_root /dev/sdb
  Volume group "vg_root" successfully created

[root@controller vagrant]# lvcreate -n lv_root -l+100%FREE /dev/vg_root
  Logical volume "lv_root" created.

[root@controller vagrant]# mkfs.xfs /dev/
Display all 161 possibilities? (y or n)

[root@controller vagrant]# mkfs.xfs /dev/vg_root/lv_root 
meta-data=/dev/vg_root/lv_root   isize=512    agcount=4, agsize=655104 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=2620416, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

[root@controller vagrant]# mount /dev/vg_root/lv_root /mnt

[root@controller vagrant]# xfsdump -J /dev/VolGroup00/LogVol00 | xfsrestore -J /mnt
xfsrestore: ERROR: no source file(s) specified
xfsrestore: Restore Status: ERROR
xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt
xfsrestore: using file dump (drive_simple) strategy
xfsrestore: version 3.1.7 (dump format 3.0)
xfsdump: using file dump (drive_simple) strategy
xfsdump: version 3.1.7 (dump format 3.0)
xfsdump: level 0 dump of controller:/
xfsdump: dump date: Sat Feb  9 17:11:58 2019
xfsdump: session id: 51edb00a-dde5-4e2c-b861-63a0eb8fb544
xfsdump: session label: ""
xfsrestore: searching media for dump
xfsdump: ino map phase 1: constructing initial dump list
xfsdump: ino map phase 2: skipping (no pruning necessary)
xfsdump: ino map phase 3: skipping (only one dump stream)
xfsdump: ino map construction complete
xfsdump: estimated dump size: 725357120 bytes
xfsdump: creating dump session media file 0 (media 0, file 0)
xfsdump: dumping ino map
xfsdump: dumping directories
xfsrestore: examining media file 0
xfsrestore: dump description: 
xfsrestore: hostname: controller
xfsrestore: mount point: /
xfsrestore: volume: /dev/mapper/VolGroup00-LogVol00
xfsrestore: session time: Sat Feb  9 17:11:58 2019
xfsrestore: level: 0
xfsrestore: session label: ""
xfsrestore: media label: ""
xfsrestore: file system id: b60e9498-0baa-4d9f-90aa-069048217fee
xfsrestore: session id: 51edb00a-dde5-4e2c-b861-63a0eb8fb544
xfsrestore: media id: d8c2ec13-b27c-44ec-8966-aa44aa748015
xfsrestore: searching media for directory dump
xfsrestore: reading directories
xfsdump: dumping non-directory files
xfsrestore: 2692 directories and 23444 entries processed
xfsrestore: directory post-processing
xfsrestore: restoring non-directory files
xfsdump: ending media file
xfsdump: media file size 702638464 bytes
xfsdump: dump size (non-dir files) : 689564048 bytes
xfsdump: dump complete: 18 seconds elapsed
xfsdump: Dump Status: SUCCESS
xfsrestore: restore complete: 18 seconds elapsed
xfsrestore: Restore Status: SUCCESS

[root@controller vagrant]# for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done
[root@controller vagrant]# ls /mnt
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  vagrant  var

[root@controller vagrant]# mount -a

[root@controller vagrant]# mount -l
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime,seclabel)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,seclabel,size=497968k,nr_inodes=124492,mode=755)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,seclabel)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,seclabel,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,seclabel,mode=755)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,seclabel,mode=755)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,xattr,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,cpuacct,cpu)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,blkio)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,pids)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,net_prio,net_cls)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,perf_event)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,freezer)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,devices)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,memory)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,cpuset)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,hugetlb)
configfs on /sys/kernel/config type configfs (rw,relatime)
/dev/mapper/VolGroup00-LogVol00 on / type xfs (rw,relatime,seclabel,attr2,inode64,noquota)
selinuxfs on /sys/fs/selinux type selinuxfs (rw,relatime)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=27,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=11995)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,seclabel)
mqueue on /dev/mqueue type mqueue (rw,relatime,seclabel)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
/dev/sda2 on /boot type xfs (rw,relatime,seclabel,attr2,inode64,noquota)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,seclabel,size=101544k,mode=700,uid=1000,gid=1000)
/dev/mapper/vg_root-lv_root on /mnt type xfs (rw,relatime,seclabel,attr2,inode64,noquota)
proc on /mnt/proc type proc (rw,nosuid,nodev,noexec,relatime)
sysfs on /mnt/sys type sysfs (rw,nosuid,nodev,noexec,relatime,seclabel)
devtmpfs on /mnt/dev type devtmpfs (rw,nosuid,seclabel,size=497968k,nr_inodes=124492,mode=755)
tmpfs on /mnt/run type tmpfs (rw,nosuid,nodev,seclabel,mode=755)
/dev/sda2 on /mnt/boot type xfs (rw,relatime,seclabel,attr2,inode64,noquota)

[root@controller vagrant]# chroot /mnt/
[kroot@controller:/[\[root@controller /]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-862.2.3.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-862.2.3.el7.x86_64.img
done
[kroot@controller:/[\[root@controller /]# cd /boot ; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g;
> s/.img//g"` --force; done
Executing: /sbin/dracut -v initramfs-3.10.0-862.2.3.el7.x86_64.img 3.10.0-862.2.3.el7.x86_64 --force
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
*** Including module: bash ***
*** Including module: nss-softokn ***
*** Including module: i18n ***
*** Including module: drm ***
*** Including module: plymouth ***
*** Including module: dm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 60-persistent-storage-dm.rules
Skipping udev rule: 55-dm.rules
*** Including module: kernel-modules ***
Omitting driver floppy
*** Including module: lvm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 56-lvm.rules
Skipping udev rule: 60-persistent-storage-lvm.rules
*** Including module: qemu ***
*** Including module: resume ***
*** Including module: rootfs-block ***
*** Including module: terminfo ***
*** Including module: udev-rules ***
Skipping udev rule: 40-redhat-cpu-hotplug.rules
Skipping udev rule: 91-permissions.rules
*** Including module: biosdevname ***
*** Including module: systemd ***
*** Including module: usrmount ***
*** Including module: base ***
*** Including module: fs-lib ***
*** Including module: shutdown ***
*** Including modules done ***
*** Installing kernel module dependencies and firmware ***
*** Installing kernel module dependencies and firmware done ***
*** Resolving executable dependencies ***
*** Resolving executable dependencies done***
*** Hardlinking files ***
*** Hardlinking files done ***
*** Stripping files ***
*** Stripping files done ***
*** Generating early-microcode cpio image contents ***
*** No early-microcode cpio image needed ***
*** Store current command line parameters ***
*** Creating image file ***
*** Creating image file done ***
*** Creating initramfs image file '/boot/initramfs-3.10.0-862.2.3.el7.x86_64.img' done
[root@controller vagrant]#vi /boot/grub2/grub.cfg

reboot


[vagrant@controller ~]$ lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   41G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-LogVol00 253:2    0 37.5G  0 lvm  
sdb                       8:16   0   10G  0 disk 
└─vg_root-lv_root       253:0    0   10G  0 lvm  /
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 

[vagrant@controller ~]$ sudo su -
Last login: Sat Feb  9 17:53:51 UTC 2019 on pts/0

[root@controller ~]# lvremove /dev/VolGroup00/LogVol00
Do you really want to remove active logical volume VolGroup00/LogVol00? [y/n]: y
  Logical volume "LogVol00" successfully removed

[root@controller ~]# lvcreate -n VolGroup00/LogVol00 -L 8G /dev/VolGroup00
WARNING: xfs signature detected on /dev/VolGroup00/LogVol00 at offset 0. Wipe it? [y/n]: y
  Wiping xfs signature on /dev/VolGroup00/LogVol00.
  Logical volume "LogVol00" created.

[root@controller ~]# mkfs.xfs /dev/VolGroup00/LogVol00
meta-data=/dev/VolGroup00/LogVol00 isize=512    agcount=4, agsize=524288 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=2097152, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

[root@controller ~]# xfsdump -J - /dev/vg_root/lv_root | xfsrestore -J - /mnt
xfsrestore: using file dump (drive_simple) strategy
xfsrestore: version 3.1.7 (dump format 3.0)
xfsdump: using file dump (drive_simple) strategy
xfsdump: version 3.1.7 (dump format 3.0)
xfsdump: level 0 dump of controller:/
xfsdump: dump date: Sat Feb  9 18:11:49 2019
xfsdump: session id: 02ffdab7-5c7f-44ba-bc17-3bb81145cdc3
xfsdump: session label: ""
xfsrestore: searching media for dump
xfsdump: ino map phase 1: constructing initial dump list
xfsdump: ino map phase 2: skipping (no pruning necessary)
xfsdump: ino map phase 3: skipping (only one dump stream)
xfsdump: ino map construction complete
xfsdump: estimated dump size: 723671680 bytes
xfsdump: creating dump session media file 0 (media 0, file 0)
xfsdump: dumping ino map
xfsdump: dumping directories
xfsrestore: examining media file 0
xfsrestore: dump description: 
xfsrestore: hostname: controller
xfsrestore: mount point: /
xfsrestore: volume: /dev/mapper/vg_root-lv_root
xfsrestore: session time: Sat Feb  9 18:11:49 2019
xfsrestore: level: 0
xfsrestore: session label: ""
xfsrestore: media label: ""
xfsrestore: file system id: 730a3615-576f-4dce-8d2b-048379ed1667
xfsrestore: session id: 02ffdab7-5c7f-44ba-bc17-3bb81145cdc3
xfsrestore: media id: b8ed37fa-83d7-402a-a1fc-690a77c5ca71
xfsrestore: searching media for directory dump
xfsrestore: reading directories
xfsdump: dumping non-directory files
xfsrestore: 2678 directories and 23431 entries processed
xfsrestore: directory post-processing
xfsrestore: restoring non-directory files
xfsdump: ending media file
xfsdump: media file size 700957824 bytes
xfsdump: dump size (non-dir files) : 687895016 bytes
xfsdump: dump complete: 32 seconds elapsed
xfsdump: Dump Status: SUCCESS
xfsrestore: restore complete: 33 seconds elapsed
xfsrestore: Restore Status: SUCCESS
[root@controller ~]# mount /dev/VolGroup00/LogVol00 /mnt
[root@controller ~]# xfsdump -J - /dev/vg_root/lv_root | xfsrestore -J - /mnt
xfsrestore: using file dump (drive_simple) strategy
xfsrestore: version 3.1.7 (dump format 3.0)
xfsrestore: searching media for dump
xfsdump: using file dump (drive_simple) strategy
xfsdump: version 3.1.7 (dump format 3.0)
xfsdump: level 0 dump of controller:/
xfsdump: dump date: Sat Feb  9 18:14:06 2019
xfsdump: session id: 1472c162-87d7-4d29-92f2-4f684810c157
xfsdump: session label: ""
xfsdump: ino map phase 1: constructing initial dump list
xfsdump: ino map phase 2: skipping (no pruning necessary)
xfsdump: ino map phase 3: skipping (only one dump stream)
xfsdump: ino map construction complete
xfsdump: estimated dump size: 1447383360 bytes
xfsdump: creating dump session media file 0 (media 0, file 0)
xfsdump: dumping ino map
xfsdump: dumping directories
xfsrestore: examining media file 0
xfsrestore: dump description: 
xfsrestore: hostname: controller
xfsrestore: mount point: /
xfsrestore: volume: /dev/mapper/vg_root-lv_root
xfsrestore: session time: Sat Feb  9 18:14:06 2019
xfsrestore: level: 0
xfsrestore: session label: ""
xfsrestore: media label: ""
xfsrestore: file system id: 730a3615-576f-4dce-8d2b-048379ed1667
xfsrestore: session id: 1472c162-87d7-4d29-92f2-4f684810c157
xfsrestore: media id: 0c196ae4-db21-48e1-96c7-4f6ef019ece6
xfsrestore: searching media for directory dump
xfsrestore: reading directories
xfsdump: dumping non-directory files
xfsrestore: 5354 directories and 46848 entries processed
xfsrestore: directory post-processing
xfsrestore: restoring non-directory files
xfsrestore: NOTE: ino 9380811 gen 3703070804 not referenced: placing in orphanage
xfsdump: ending media file
xfsdump: media file size 1401823200 bytes
xfsdump: dump size (non-dir files) : 1375704192 bytes
xfsdump: dump complete: 71 seconds elapsed
xfsdump: Dump Status: SUCCESS
xfsrestore: WARNING: unable to rmdir /mnt/orphanage: Directory not empty
xfsrestore: restore complete: 72 seconds elapsed
xfsrestore: Restore Status: SUCCESS
[root@controller ~]# for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done
[root@controller ~]# chroot /mnt/
[root@controller /]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-862.2.3.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-862.2.3.el7.x86_64.img
done

[root@controller /]# cd /boot ; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g;s/.img//g"` --force; done
Executing: /sbin/dracut -v initramfs-3.10.0-862.2.3.el7.x86_64.img 3.10.0-862.2.3.el7.x86_64 --force
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
*** Including module: bash ***
*** Including module: nss-softokn ***
*** Including module: i18n ***
*** Including module: drm ***
*** Including module: plymouth ***
*** Including module: dm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 60-persistent-storage-dm.rules
Skipping udev rule: 55-dm.rules
*** Including module: kernel-modules ***
Omitting driver floppy
*** Including module: lvm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 56-lvm.rules
Skipping udev rule: 60-persistent-storage-lvm.rules
*** Including module: qemu ***
*** Including module: resume ***
*** Including module: rootfs-block ***
*** Including module: terminfo ***
*** Including module: udev-rules ***
Skipping udev rule: 40-redhat-cpu-hotplug.rules
Skipping udev rule: 91-permissions.rules
*** Including module: biosdevname ***
*** Including module: systemd ***
*** Including module: usrmount ***
*** Including module: base ***
*** Including module: fs-lib ***
*** Including module: shutdown ***
*** Including modules done ***
*** Installing kernel module dependencies and firmware ***
*** Installing kernel module dependencies and firmware done ***
*** Resolving executable dependencies ***
*** Resolving executable dependencies done***
*** Hardlinking files ***
*** Hardlinking files done ***
*** Stripping files ***
*** Stripping files done ***
*** Generating early-microcode cpio image contents ***
*** No early-microcode cpio image needed ***
*** Store current command line parameters ***
*** Creating image file ***
*** Creating image file done ***
*** Creating initramfs image file '/boot/initramfs-3.10.0-862.2.3.el7.x86_64.img' done ***

[root@controller boot]# pvcreate /dev/sdc /dev/sdd
  Physical volume "/dev/sdc" successfully created.
  Physical volume "/dev/sdd" successfully created.

[root@controller boot]# vgcreate vg_var /dev/sdc /dev/sdd
  Volume group "vg_var" successfully created

[root@controller boot]# lvcreate -L 950M -m1 -n lv_var vg_var
  Rounding up size to full physical extent 952.00 MiB
  Logical volume "lv_var" created.

[root@controller boot]# mkfs.ext4 /dev/vg_var/lv_var
mke2fs 1.42.9 (28-Dec-2013)
Discarding device blocks: done                            
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
60928 inodes, 243712 blocks
12185 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=249561088
8 block groups
32768 blocks per group, 32768 fragments per group
7616 inodes per group
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

[root@controller boot]# mount /dev/vg_var/lv_var /mnt

[root@controller boot]# cp -aR /var/* /mnt/

[root@controller boot]# mkdir /tmp/oldvar && mv /var/* /tmp/oldvar

[root@controller boot]# umount /mnt

[root@controller boot]# mount /dev/vg_var/lv_var /var

[root@controller boot]# echo "`blkid | grep var: | awk '{print $2}'` /var ext4 defaults 0 0" >> /etc/fstab
[root@controller boot]# reboot

[root@controller ~]# lsblk
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                        8:0    0   41G  0 disk 
├─sda1                     8:1    0    1M  0 part 
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00  253:0    0    8G  0 lvm  /
  └─VolGroup00-LogVol01  253:1    0  1.5G  0 lvm  [SWAP]
sdb                        8:16   0   10G  0 disk 
└─vg_root-lv_root        253:2    0   10G  0 lvm  
sdc                        8:32   0    2G  0 disk 
├─vg_var-lv_var_rmeta_0  253:3    0    4M  0 lvm  
│ └─vg_var-lv_var        253:7    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_0 253:4    0  952M  0 lvm  
  └─vg_var-lv_var        253:7    0  952M  0 lvm  /var
sdd                        8:48   0    1G  0 disk 
├─vg_var-lv_var_rmeta_1  253:5    0    4M  0 lvm  
│ └─vg_var-lv_var        253:7    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_1 253:6    0  952M  0 lvm  
  └─vg_var-lv_var        253:7    0  952M  0 lvm  /var
sde                        8:64   0    1G  0 disk 

[root@controller ~]# lvremove /dev/vg_root/lv_root
Do you really want to remove active logical volume vg_root/lv_root? [y/n]: y
  Logical volume "lv_root" successfully removed

[root@controller ~]# vgremove /dev/vg_root
  Volume group "vg_root" successfully removed

[root@controller ~]# pvremove /dev/sdb
  Labels on physical volume "/dev/sdb" successfully wiped.

[root@controller ~]# lvcreate -n LogVol_Home -L 2G /dev/VolGroup00
  Logical volume "LogVol_Home" created.

[root@controller ~]# mkfs.xfs /dev/VolGroup00/LogVol_Home
meta-data=/dev/VolGroup00/LogVol_Home isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

[root@controller ~]# mount /dev/VolGroup00/LogVol_Home /mnt/

[root@controller ~]# cp -aR /home/* /mnt/

[root@controller ~]# rm -rf /home/*

[root@controller ~]# umount /mnt

[root@controller ~]# mount /dev/VolGroup00/LogVol_Home /home/

[root@controller ~]# echo "`blkid | grep Home | awk '{print $2}'` /home xfs defaults 0 0" >> /etc/fstab

[root@controller ~]# touch /home/file{1..20}

[root@controller ~]# lvcreate -L 100MB -s -n home_snap /dev/VolGroup00/LogVol_Home
  Rounding up size to full physical extent 128.00 MiB
  Logical volume "home_snap" created.

[root@controller ~]# ls /home/
file1   file11  file13  file15  file17  file19  file20  file4  file6  file8  vagrant
file10  file12  file14  file16  file18  file2   file3   file5  file7  file9

[root@controller ~]# rm -f /home/file{11..20}

[root@controller ~]# umount /home

[root@controller ~]# lvconvert --merge /dev/VolGroup00/home_snap
  Merging of volume VolGroup00/home_snap started.
  VolGroup00/LogVol_Home: Merged: 100.00%

[root@controller ~]# mount /home


