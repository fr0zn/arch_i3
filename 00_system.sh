#!/bin/bash

if [[ -f `pwd`/funcs.sh ]]; then
  source funcs.sh
else
  echo "missing file: funcs.sh"
  exit 1
fi

#ARCHLINUX INSTALL SCRIPTS MODE {{{
#SELECT KEYMAP {{{
select_keymap(){
  print_title "KEYMAP - https://wiki.archlinux.org/index.php/KEYMAP"
  keymap_list=("ANSI-dvorak" "amiga-de" "amiga-us" "applkey" "atari-de" "atari-se" "atari-uk-falcon" "atari-us" "azerty" "backspace" "bashkir" "be-latin1" "bg-cp1251" "bg-cp855" "bg_bds-cp1251" "bg_bds-utf8" "bg_pho-cp1251" "bg_pho-utf8" "br-abnt" "br-abnt2" "br-latin1-abnt2" "br-latin1-us" "by" "by-cp1251" "bywin-cp1251" "cf" "colemak" "croat" "ctrl" "cz" "cz-cp1250" "cz-lat2" "cz-lat2-prog" "cz-qwertz" "cz-us-qwertz" "de" "de-latin1" "de-latin1-nodeadkeys" "de-mobii" "de_CH-latin1" "de_alt_UTF-8" "defkeymap" "defkeymap_V1.0" "dk" "dk-latin1" "dvorak" "dvorak-ca-fr" "dvorak-es" "dvorak-fr" "dvorak-l" "dvorak-la" "dvorak-programmer" "dvorak-r" "dvorak-ru" "dvorak-sv-a1" "dvorak-sv-a5" "dvorak-uk" "emacs" "emacs2" "es" "es-cp850" "es-olpc" "et" "et-nodeadkeys" "euro" "euro1" "euro2" "fi" "fr" "fr-bepo" "fr-bepo-latin9" "fr-latin1" "fr-latin9" "fr-pc" "fr_CH" "fr_CH-latin1" "gr" "gr-pc" "hu" "hu101" "il" "il-heb" "il-phonetic" "is-latin1" "is-latin1-us" "it" "it-ibm" "it2" "jp106" "kazakh" "keypad" "ky_alt_sh-UTF-8" "kyrgyz" "la-latin1" "lt" "lt.baltic" "lt.l4" "lv" "lv-tilde" "mac-be" "mac-de-latin1" "mac-de-latin1-nodeadkeys" "mac-de_CH" "mac-dk-latin1" "mac-dvorak" "mac-es" "mac-euro" "mac-euro2" "mac-fi-latin1" "mac-fr" "mac-fr_CH-latin1" "mac-it" "mac-pl" "mac-pt-latin1" "mac-se" "mac-template" "mac-uk" "mac-us" "mk" "mk-cp1251" "mk-utf" "mk0" "nl" "nl2" "no" "no-dvorak" "no-latin1" "pc110" "pl" "pl1" "pl2" "pl3" "pl4" "pt-latin1" "pt-latin9" "pt-olpc" "ro" "ro_std" "ro_win" "ru" "ru-cp1251" "ru-ms" "ru-yawerty" "ru1" "ru2" "ru3" "ru4" "ru_win" "ruwin_alt-CP1251" "ruwin_alt-KOI8-R" "ruwin_alt-UTF-8" "ruwin_alt_sh-UTF-8" "ruwin_cplk-CP1251" "ruwin_cplk-KOI8-R" "ruwin_cplk-UTF-8" "ruwin_ct_sh-CP1251" "ruwin_ct_sh-KOI8-R" "ruwin_ct_sh-UTF-8" "ruwin_ctrl-CP1251" "ruwin_ctrl-KOI8-R" "ruwin_ctrl-UTF-8" "se-fi-ir209" "se-fi-lat6" "se-ir209" "se-lat6" "sg" "sg-latin1" "sg-latin1-lk450" "sk-prog-qwerty" "sk-prog-qwertz" "sk-qwerty" "sk-qwertz" "slovene" "sr-cy" "sun-pl" "sun-pl-altgraph" "sundvorak" "sunkeymap" "sunt4-es" "sunt4-fi-latin1" "sunt4-no-latin1" "sunt5-cz-us" "sunt5-de-latin1" "sunt5-es" "sunt5-fi-latin1" "sunt5-fr-latin1" "sunt5-ru" "sunt5-uk" "sunt5-us-cz" "sunt6-uk" "sv-latin1" "tj_alt-UTF8" "tr_f-latin5" "tr_q-latin5" "tralt" "trf" "trf-fgGIod" "trq" "ttwin_alt-UTF-8" "ttwin_cplk-UTF-8" "ttwin_ct_sh-UTF-8" "ttwin_ctrl-UTF-8" "ua" "ua-cp1251" "ua-utf" "ua-utf-ws" "ua-ws" "uk" "unicode" "us" "us-acentos" "wangbe" "wangbe2" "windowkeys");
  PS3="$prompt1"
  print_info "The KEYMAP variable is specified in the /etc/rc.conf file. It defines what keymap the keyboard is in the virtual consoles. Keytable files are provided by the kbd package."
  echo "keymap list in /usr/share/kbd/keymaps"
    select KEYMAP in "${keymap_list[@]}"; do
    if contains_element "$KEYMAP" "${keymap_list[@]}"; then
      loadkeys "$KEYMAP";
      break
    else
      invalid_option
    fi
    done
}
#}}}
#DEFAULT EDITOR {{{
select_editor(){
  print_title "DEFAULT EDITOR"
  editors_list=("vim" "vim" "neovim" "emacs");
  PS3="$prompt1"
  echo -e "Select editor\n"
  select EDITOR in "${editors_list[@]}"; do
    if contains_element "$EDITOR" "${editors_list[@]}"; then
      package_install "$EDITOR"
      break
    else
      invalid_option
    fi
  done
}
#}}}
#MIRRORLIST {{{
configure_mirrorlist(){
  local countries_code=("AU" "AT" "BY" "BE" "BR" "BG" "CA" "CL" "CN" "CO" "CZ" "DK" "EE" "FI" "FR" "DE" "GR" "HK" "HU" "ID" "IN" "IR" "IE" "IL" "IT" "JP" "KZ" "KR" "LV" "LU" "MK" "NL" "NC" "NZ" "NO" "PL" "PT" "RO" "RU" "RS" "SG" "SK" "ZA" "ES" "LK" "SE" "CH" "TW" "TR" "UA" "GB" "US" "UZ" "VN")
  local countries_name=("Australia" "Austria" "Belarus" "Belgium" "Brazil" "Bulgaria" "Canada" "Chile" "China" "Colombia" "Czech Republic" "Denmark" "Estonia" "Finland" "France" "Germany" "Greece" "Hong Kong" "Hungary" "Indonesia" "India" "Iran" "Ireland" "Israel" "Italy" "Japan" "Kazakhstan" "Korea" "Latvia" "Luxembourg" "Macedonia" "Netherlands" "New Caledonia" "New Zealand" "Norway" "Poland" "Portugal" "Romania" "Russia" "Serbia" "Singapore" "Slovakia" "South Africa" "Spain" "Sri Lanka" "Sweden" "Switzerland" "Taiwan" "Turkey" "Ukraine" "United Kingdom" "United States" "Uzbekistan" "Viet Nam")
  country_list(){
    #`reflector --list-countries | sed 's/[0-9]//g' | sed 's/^/"/g' | sed 's/,.*//g' | sed 's/ *$//g'  | sed 's/$/"/g' | sed -e :a -e '$!N; s/\n/ /; ta'`
    PS3="$prompt1"
    echo "Select your country:"
    select country_name in "${countries_name[@]}"; do
      if contains_element "$country_name" "${countries_name[@]}"; then
        country_code=${countries_code[$(( $REPLY - 1 ))]}
        break
      else
        invalid_option
      fi
    done
  }
  print_title "MIRRORLIST - https://wiki.archlinux.org/index.php/Mirrors"
  print_info "This option is a guide to selecting and configuring your mirrors, and a listing of current available mirrors."
  OPTION=n
  while [[ $OPTION != y ]]; do
    country_list
    read_input_text "Confirm country: $country_name"
  done

  url="https://www.archlinux.org/mirrorlist/?country=${country_code}&use_mirror_status=on"

  tmpfile=$(mktemp --suffix=-mirrorlist)

  # Get latest mirror list and save to tmpfile
  curl -so ${tmpfile} ${url}
  sed -i 's/^#Server/Server/g' ${tmpfile}

  # Backup and replace current mirrorlist file (if new file is non-zero)
  if [[ -s ${tmpfile} ]]; then
   { echo " Backing up the original mirrorlist..."
     mv -i /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig; } &&
   { echo " Rotating the new list into place..."
     mv -i ${tmpfile} /etc/pacman.d/mirrorlist; }
  else
    echo " Unable to update, could not download list."
  fi
  # better repo should go first
  cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.tmp
  rankmirrors /etc/pacman.d/mirrorlist.tmp > /etc/pacman.d/mirrorlist
  rm /etc/pacman.d/mirrorlist.tmp
  # allow global read access (required for non-root yaourt execution)
  chmod +r /etc/pacman.d/mirrorlist
  $EDITOR /etc/pacman.d/mirrorlist
}
#}}}
#SETUP ALTERNATIVE DNS {{{
setup_alt_dns(){
  cat <<- EOF > /etc/resolv.conf.head
# OpenDNS IPv4 nameservers
nameserver 208.67.222.222
nameserver 208.67.220.220
# OpenDNS IPv6 nameservers
nameserver 2620:0:ccc::2
nameserver 2620:0:ccd::2

# Google IPv4 nameservers
nameserver 8.8.8.8
nameserver 8.8.4.4
# Google IPv6 nameservers
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844
EOF
}
#}}}
#UMOUNT PARTITIONS {{{
umount_partitions(){
  mounted_partitions=(`lsblk | grep ${MOUNTPOINT} | awk '{print $7}' | sort -r`)
  swapoff -a
  for i in ${mounted_partitions[@]}; do
    umount $i
  done
}
#}}}
#SELECT DEVICE {{{
select_device(){
  devices_list=(`lsblk -d | awk '{print "/dev/" $1}' | grep 'sd\|hd\|vd\|nvme\|mmcblk'`);
  PS3="$prompt1"
  echo -e "Attached Devices:\n"
  lsblk -lnp -I 2,3,8,9,22,34,56,57,58,65,66,67,68,69,70,71,72,91,128,129,130,131,132,133,134,135,259 | awk '{print $1,$4,$6,$7}'| column -t
  echo -e "\n"
  echo -e "Select device to partition:\n"
  select device in "${devices_list[@]}"; do
    if contains_element "${device}" "${devices_list[@]}"; then
      break
    else
      invalid_option
    fi
  done
  BOOT_MOUNTPOINT=$device
}
#}}}
#CREATE PARTITION SCHEME {{{
create_partition_scheme(){
  LUKS=0
  LVM=0
  print_title "https://wiki.archlinux.org/index.php/Partitioning"
  print_info "Partitioning a hard drive allows one to logically divide the available space into sections that can be accessed independently of one another."
  print_warning "Maintain Current does not work with LUKS"
  partition_layouts=("Default" "LVM" "LVM+LUKS" "Maintain Current")
  PS3="$prompt1"
  echo -e "Select partition scheme:"
  select OPT in "${partition_layouts[@]}"; do
    partition_layout=$OPT
    case "$REPLY" in
      1)
        create_partition
        ;;
      2)
        create_partition
        setup_lvm
        ;;
      3)
        create_partition
        setup_luks
        setup_lvm
        ;;
      4)
        modprobe dm-mod
        vgscan &> /dev/null
        vgchange -ay &> /dev/null
        ;;
      *)
        invalid_option
        ;;
    esac
    [[ -n $OPT ]] && break
  done
}
#}}}
#SETUP PARTITION{{{
create_partition(){
  # partitions based on boot system
  if [[ $UEFI -eq 1 ]]; then
    local partitions="root, EFI, swap"
  else
    local partitions="root, swap"
  fi

  print_info "Create atleast the following partitions: $partitions"

  apps_list=("cfdisk" "cgdisk" "fdisk" "gdisk" "parted");
  PS3="$prompt1"
  echo -e "Select partition program:"
  select OPT in "${apps_list[@]}"; do
    if contains_element "$OPT" "${apps_list[@]}"; then
      select_device
      case $OPT in
        parted)
          parted -a opt ${device}
          ;;
        *)
          $OPT ${device}
          ;;
      esac
      break
    else
      invalid_option
    fi
  done
}
#}}}
#SETUP LUKS {{{
setup_luks(){
  print_title "LUKS - https://wiki.archlinux.org/index.php/LUKS"
  print_info "The Linux Unified Key Setup or LUKS is a disk-encryption specification created by Clemens Fruhwirth and originally intended for Linux."
  print_danger "\tDo not use this for boot partitions"
  block_list=(`lsblk | grep 'part' | awk '{print "/dev/" substr($1,3)}'`)
  PS3="$prompt1"
  echo -e "Select partition:"
  select OPT in "${block_list[@]}"; do
    if contains_element "$OPT" "${block_list[@]}"; then
      cryptsetup --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 --use-random --verify-passphrase luksFormat $OPT
      cryptsetup open --type luks $([[ $TRIM -eq 1 ]] && echo "--allow-discards") $OPT crypt
      LUKS=1
      LUKS_DISK=`echo ${OPT} | sed 's/\/dev\///'`
      break
    elif [[ $OPT == "Cancel" ]]; then
      break
    else
      invalid_option
    fi
  done
}
#}}}
#SETUP LVM {{{
setup_lvm(){
  print_title "LVM - https://wiki.archlinux.org/index.php/LVM"
  print_info "LVM is a logical volume manager for the Linux kernel; it manages disk drives and similar mass-storage devices. "
  print_warning "Last partition will take 100% of free space left"
  if [[ $LUKS -eq 1 ]]; then
    pvcreate /dev/mapper/crypt
    vgcreate lvm /dev/mapper/crypt
  else
    block_list=(`lsblk | grep 'part' | awk '{print "/dev/" substr($1,3)}'`)
    PS3="$prompt1"
    echo -e "Select partition:"
    select OPT in "${block_list[@]}"; do
      if contains_element "$OPT" "${block_list[@]}"; then
        pvcreate $OPT
        vgcreate lvm $OPT
        break
      else
        invalid_option
      fi
    done
  fi
  read -p "Enter number of partitions [ex: 2]: " number_partitions
  i=1
  while [[ $i -le $number_partitions ]]; do
    read -p "Enter $iª partition name [ex: home]: " partition_name
    if [[ $i -eq $number_partitions ]]; then
      lvcreate -l 100%FREE lvm -n ${partition_name}
    else
      read -p "Enter $iª partition size [ex: 25G, 200M]: " partition_size
      lvcreate -L ${partition_size} lvm -n ${partition_name}
    fi
    i=$(( i + 1 ))
  done
  LVM=1
}
#}}}
#SELECT|FORMAT PARTITIONS {{{
format_partitions(){
  print_title "https://wiki.archlinux.org/index.php/File_Systems"
  print_info "This step will select and format the selected partition where archlinux will be installed"
  print_danger "\tAll data on the ROOT and SWAP partition will be LOST."
  i=0

  block_list=(`lsblk | grep 'part\|lvm' | awk '{print substr($1,3)}'`)

  # check if there is no partition
  if [[ ${#block_list[@]} -eq 0 ]]; then
    echo "No partition found"
    exit 0
  fi

  partitions_list=()
  for OPT in ${block_list[@]}; do
    check_lvm=`echo $OPT | grep lvm`
    if [[ -z $check_lvm ]]; then
      partitions_list+=("/dev/$OPT")
    else
      partitions_list+=("/dev/mapper/$OPT")
    fi
  done

  # partitions based on boot system
  if [[ $UEFI -eq 1 ]]; then
    partition_name=("root" "EFI" "swap" "another")
  else
    partition_name=("root" "swap" "another")
  fi

  select_filesystem(){
    filesystems_list=( "btrfs" "ext2" "ext3" "ext4" "f2fs" "jfs" "nilfs2" "ntfs" "vfat" "xfs");
    PS3="$prompt1"
    echo -e "Select filesystem:\n"
    select filesystem in "${filesystems_list[@]}"; do
      if contains_element "${filesystem}" "${filesystems_list[@]}"; then
        break
      else
        invalid_option
      fi
    done
  }

  disable_partition(){
    #remove the selected partition from list
    unset partitions_list[${partition_number}]
    partitions_list=(${partitions_list[@]})
    #increase i
    [[ ${partition_name[i]} != another ]] && i=$(( i + 1 ))
  }

  format_partition(){
    read_input_text "Confirm format $1 partition"
    if [[ $OPTION == y ]]; then
      [[ -z $3 ]] && select_filesystem || filesystem=$3
      mkfs.${filesystem} $1 \
        $([[ ${filesystem} == xfs || ${filesystem} == btrfs ]] && echo "-f") \
        $([[ ${filesystem} == vfat ]] && echo "-F32") \
        $([[ $TRIM -eq 1 && ${filesystem} == ext4 ]] && echo "-E discard") \
        $([[ $TRIM -eq 1 && ${filesystem} == btrfs ]] && echo "-O discard")
      fsck $1
      mkdir -p $2
      mount -t ${filesystem} $1 $2
      disable_partition
    fi
  }

  format_swap_partition(){
    read_input_text "Confirm format $1 partition"
    if [[ $OPTION == y ]]; then
      mkswap $1
      swapon $1
      disable_partition
    fi
  }

  create_swap(){
    swap_options=("partition" "file" "skip");
    PS3="$prompt1"
    echo -e "Select ${BYellow}${partition_name[i]}${Reset} filesystem:\n"
    select OPT in "${swap_options[@]}"; do
      case "$REPLY" in
        1)
          select partition in "${partitions_list[@]}"; do
            #get the selected number - 1
            partition_number=$(( $REPLY - 1 ))
            if contains_element "${partition}" "${partitions_list[@]}"; then
              format_swap_partition "${partition}"
            fi
            break
          done
          swap_type="partition"
          break
          ;;
        2)
          total_memory=`grep MemTotal /proc/meminfo | awk '{print $2/1024}' | sed 's/\..*//'`
          fallocate -l ${total_memory}M ${MOUNTPOINT}/swapfile
          chmod 600 ${MOUNTPOINT}/swapfile
          mkswap ${MOUNTPOINT}/swapfile
          swapon ${MOUNTPOINT}/swapfile
          i=$(( i + 1 ))
          swap_type="file"
          break
          ;;
        3)
          i=$(( i + 1 ))
          swap_type="none"
          break
          ;;
        *)
          invalid_option
          ;;
      esac
    done
  }

  check_mountpoint(){
    if mount | grep $2; then
      echo "Successfully mounted"
      disable_partition "$1"
    else
      echo "WARNING: Not Successfully mounted"
    fi
  }

  set_efi_partition(){
    efi_options=("/boot/efi" "/boot")
    PS3="$prompt1"
    echo -e "Select EFI mountpoint:\n"
    select EFI_MOUNTPOINT in "${efi_options[@]}"; do
      if contains_element "${EFI_MOUNTPOINT}" "${efi_options[@]}"; then
        break
      else
        invalid_option
      fi
    done
  }

  while true; do
    PS3="$prompt1"
    if [[ ${partition_name[i]} == swap ]]; then
      create_swap
    else
      echo -e "Select ${BYellow}${partition_name[i]}${Reset} partition:\n"
      select partition in "${partitions_list[@]}"; do
        #get the selected number - 1
        partition_number=$(( $REPLY - 1 ))
        if contains_element "${partition}" "${partitions_list[@]}"; then
          case ${partition_name[i]} in
            root)
              ROOT_PART=`echo ${partition} | sed 's/\/dev\/mapper\///' | sed 's/\/dev\///'`
              ROOT_MOUNTPOINT=${partition}
              format_partition "${partition}" "${MOUNTPOINT}"
              ;;
            EFI)
              set_efi_partition
              read_input_text "Format ${partition} partition"
              if [[ $OPTION == y ]]; then
                format_partition "${partition}" "${MOUNTPOINT}${EFI_MOUNTPOINT}" vfat
              else
                mkdir -p "${MOUNTPOINT}${EFI_MOUNTPOINT}"
                mount -t vfat "${partition}" "${MOUNTPOINT}${EFI_MOUNTPOINT}"
                check_mountpoint "${partition}" "${MOUNTPOINT}${EFI_MOUNTPOINT}"
              fi
              ;;
            another)
              read -p "Mountpoint [ex: /home]:" directory
              [[ $directory == "/boot" ]] && BOOT_MOUNTPOINT=`echo ${partition} | sed 's/[0-9]//'`
              select_filesystem
              read_input_text "Format ${partition} partition"
              if [[ $OPTION == y ]]; then
                format_partition "${partition}" "${MOUNTPOINT}${directory}" "${filesystem}"
              else
                read_input_text "Confirm fs="${filesystem}" part="${partition}" dir="${directory}""
                if [[ $OPTION == y ]]; then
                  mkdir -p ${MOUNTPOINT}${directory}
                  mount -t ${filesystem} ${partition} ${MOUNTPOINT}${directory}
                  check_mountpoint "${partition}" "${MOUNTPOINT}${directory}"
                fi
              fi
              ;;
          esac
          break
        else
          invalid_option
        fi
      done
    fi
    #check if there is no partitions left
    if [[ ${#partitions_list[@]} -eq 0 && ${partition_name[i]} != swap ]]; then
      break
    elif [[ ${partition_name[i]} == another ]]; then
      read_input_text "Configure more partitions"
      [[ $OPTION != y ]] && break
    fi
  done
  pause_function
}
#}}}
#INSTALL BASE SYSTEM {{{
select_linux_version() {
  print_title "LINUX VERSION"
  version_list=("linux (default)" "linux-lts (long term support)" "linux-hardened (security features)");
  PS3="$prompt1"
  echo -e "Select linux version to install\n"
  select VERSION in "${version_list[@]}"; do
    if contains_element "$VERSION" "${version_list[@]}"; then
       if [ "linux (default)" == "$VERSION" ];then
          pacstrap ${MOUNTPOINT} base linux-headers
       elif [ "linux-lts (long term support)" == "$VERSION" ];then
          pacman -Sg base | cut -d ' ' -f 2 | sed s/\^linux\$/linux-lts/g | pacstrap ${MOUNTPOINT} - linux-lts-headers
       elif [ "linux-hardened (security features)" == "$VERSION" ];then
          pacman -Sg base | cut -d ' ' -f 2 | sed s/\^linux\$/linux-hardened/g | pacstrap ${MOUNTPOINT} - linux-hardened-headers
      fi
      break
    else
      invalid_option
    fi
  done
}
install_base_system(){
  print_title "INSTALL BASE SYSTEM"
  print_info "Installing PGP keyring"
  pacman -Sy archlinux-keyring
  print_info "Using the pacstrap script we install the base system. The base-devel package group will be installed also."
  rm ${MOUNTPOINT}${EFI_MOUNTPOINT}/vmlinuz-linux
  select_linux_version
  pacstrap ${MOUNTPOINT} base-devel parted btrfs-progs f2fs-tools ntp net-tools
  [[ $? -ne 0 ]] && error_msg "Installing base system to ${MOUNTPOINT} failed. Check error messages above."
  local PTABLE=`parted -l | grep "gpt"`
  [[ -n $PTABLE ]] && pacstrap ${MOUNTPOINT} gptfdisk
  WIRELESS_DEV=`ip link | grep wl | awk '{print $2}'| sed 's/://' | sed '1!d'`
  if [[ -n $WIRELESS_DEV ]]; then
    pacstrap ${MOUNTPOINT} iw wireless_tools wpa_actiond wpa_supplicant dialog
  else
    WIRED_DEV=`ip link | grep "ens\|eno\|enp" | awk '{print $2}'| sed 's/://' | sed '1!d'`
    if [[ -n $WIRED_DEV ]]; then
      arch_chroot "systemctl enable dhcpcd@${WIRED_DEV}.service"
    fi
  fi
  if is_package_installed "espeakup"; then
    pacstrap ${MOUNTPOINT} alsa-utils espeakup brltty
    arch_chroot "systemctl enable espeakup.service"
  fi
}
#}}}
#CONFIGURE KEYMAP {{{
configure_keymap(){
  #ADD KEYMAP TO THE NEW SETUP
  echo "KEYMAP=$KEYMAP" > ${MOUNTPOINT}/etc/vconsole.conf
}
#}}}
#CONFIGURE FSTAB {{{
configure_fstab(){
  print_title "FSTAB - https://wiki.archlinux.org/index.php/Fstab"
  print_info "The /etc/fstab file contains static filesystem information. It defines how storage devices and partitions are to be mounted and integrated into the overall system. It is read by the mount command to determine which options to use when mounting a specific partition or partition."
  if [[ ! -f ${MOUNTPOINT}/etc/fstab.aui ]]; then
    cp ${MOUNTPOINT}/etc/fstab ${MOUNTPOINT}/etc/fstab.aui
  else
    cp ${MOUNTPOINT}/etc/fstab.aui ${MOUNTPOINT}/etc/fstab
  fi
  if [[ $UEFI -eq 1 ]]; then
    fstab_list=("DEV" "PARTUUID" "LABEL");
  else
    fstab_list=("DEV" "UUID" "LABEL");
  fi

  PS3="$prompt1"
  echo -e "Configure fstab based on:"
  select OPT in "${fstab_list[@]}"; do
    case "$REPLY" in
      1) genfstab -p ${MOUNTPOINT} >> ${MOUNTPOINT}/etc/fstab ;;
      2) if [[ $UEFI -eq 1 ]]; then
          genfstab -t PARTUUID -p ${MOUNTPOINT} >> ${MOUNTPOINT}/etc/fstab
         else
          genfstab -U -p ${MOUNTPOINT} >> ${MOUNTPOINT}/etc/fstab
         fi
         ;;
      3) genfstab -L -p ${MOUNTPOINT} >> ${MOUNTPOINT}/etc/fstab ;;
      *) invalid_option ;;
    esac
    [[ -n $OPT ]] && break
  done
  fstab=$OPT
  echo "Review your fstab"
  [[ -f ${MOUNTPOINT}/swapfile ]] && sed -i "s/\\${MOUNTPOINT}//" ${MOUNTPOINT}/etc/fstab
  pause_function
  $EDITOR ${MOUNTPOINT}/etc/fstab
}
#}}}
#CONFIGURE HOSTNAME {{{
configure_hostname(){
  print_title "HOSTNAME - https://wiki.archlinux.org/index.php/HOSTNAME"
  print_info "A host name is a unique name created to identify a machine on a network.Host names are restricted to alphanumeric characters.\nThe hyphen (-) can be used, but a host name cannot start or end with it. Length is restricted to 63 characters."
  read -p "Hostname [ex: archlinux]: " host_name
  echo "$host_name" > ${MOUNTPOINT}/etc/hostname
  if [[ ! -f ${MOUNTPOINT}/etc/hosts.aui ]]; then
    cp ${MOUNTPOINT}/etc/hosts ${MOUNTPOINT}/etc/hosts.aui
  else
    cp ${MOUNTPOINT}/etc/hosts.aui ${MOUNTPOINT}/etc/hosts
  fi
  arch_chroot "sed -i '/127.0.0.1/s/$/ '${host_name}'/' /etc/hosts"
  arch_chroot "sed -i '/::1/s/$/ '${host_name}'/' /etc/hosts"
}
#}}}
#CONFIGURE TIMEZONE {{{
configure_timezone(){
  print_title "TIMEZONE - https://wiki.archlinux.org/index.php/Timezone"
  print_info "In an operating system the time (clock) is determined by four parts: Time value, Time standard, Time Zone, and DST (Daylight Saving Time if applicable)."
  OPTION=n
  while [[ $OPTION != y ]]; do
    settimezone
    read_input_text "Confirm timezone (${ZONE}/${SUBZONE})"
  done
  arch_chroot "ln -sf /usr/share/zoneinfo/${ZONE}/${SUBZONE} /etc/localtime"
  arch_chroot "sed -i '/#NTP=/d' /etc/systemd/timesyncd.conf"
  arch_chroot "sed -i 's/#Fallback//' /etc/systemd/timesyncd.conf"
  arch_chroot "echo \"FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org\" >> /etc/systemd/timesyncd.conf"
  arch_chroot "systemctl enable systemd-timesyncd.service"
}
#}}}
#CONFIGURE HARDWARECLOCK {{{
configure_hardwareclock(){
  print_title "HARDWARE CLOCK TIME - https://wiki.archlinux.org/index.php/Internationalization"
  print_info "This is set in /etc/adjtime. Set the hardware clock mode uniformly between your operating systems on the same machine. Otherwise, they will overwrite the time and cause clock shifts (which can cause time drift correction to be miscalibrated)."
  hwclock_list=('UTC' 'Localtime');
  PS3="$prompt1"
  select OPT in "${hwclock_list[@]}"; do
    case "$REPLY" in
      1) arch_chroot "hwclock --systohc --utc";
        ;;
      2) arch_chroot "hwclock --systohc --localtime";
        ;;
      *) invalid_option ;;
    esac
    [[ -n $OPT ]] && break
  done
  hwclock=$OPT
}
#}}}
#CONFIGURE LOCALE {{{
configure_locale(){
  print_title "LOCALE - https://wiki.archlinux.org/index.php/Locale"
  print_info "Locales are used in Linux to define which language the user uses. As the locales define the character sets being used as well, setting up the correct locale is especially important if the language contains non-ASCII characters."
  OPTION=n
  while [[ $OPTION != y ]]; do
    setlocale
    read_input_text "Confirm locale ($LOCALE)"
  done
  echo 'LANG="'$LOCALE_UTF8'"' > ${MOUNTPOINT}/etc/locale.conf
  arch_chroot "sed -i 's/#'${LOCALE_UTF8}'/'${LOCALE_UTF8}'/' /etc/locale.gen"
  arch_chroot "locale-gen"
}
#}}}
#CONFIGURE MKINITCPIO {{{
configure_mkinitcpio(){
  print_title "MKINITCPIO - https://wiki.archlinux.org/index.php/Mkinitcpio"
  print_info "mkinitcpio is a Bash script used to create an initial ramdisk environment."
  [[ $LUKS -eq 1 ]] && sed -i '/^HOOK/s/block/block keymap encrypt/' ${MOUNTPOINT}/etc/mkinitcpio.conf
  [[ $LVM -eq 1 ]] && sed -i '/^HOOK/s/filesystems/lvm2 filesystems/' ${MOUNTPOINT}/etc/mkinitcpio.conf
  if [ "$(arch-chroot ${MOUNTPOINT} ls /boot | grep hardened -c)" -gt "0" ]; then
    arch_chroot "mkinitcpio -p linux-hardened"
  elif [ "$(arch-chroot ${MOUNTPOINT} ls /boot | grep lts -c)" -gt "0" ]; then
    arch_chroot "mkinitcpio -p linux-lts"
  else
    arch_chroot "mkinitcpio -p linux"
  fi
}
#}}}
#INSTALL BOOTLOADER {{{
install_bootloader(){
  print_title "BOOTLOADER - https://wiki.archlinux.org/index.php/Bootloader"
  print_info "The boot loader is responsible for loading the kernel and initial RAM disk before initiating the boot process."
  print_warning "\tROOT Partition: ${ROOT_MOUNTPOINT}"
  if [[ $UEFI -eq 1 ]]; then
    print_warning "\tUEFI Mode Detected"
    bootloaders_list=("Grub2" "Syslinux" "Systemd" "rEFInd" "Skip")
  else
    print_warning "\tBIOS Mode Detected"
    bootloaders_list=("Grub2" "Syslinux" "Skip")
  fi
  PS3="$prompt1"
  echo -e "Install bootloader:\n"
  select bootloader in "${bootloaders_list[@]}"; do
    case "$REPLY" in
      1)
        pacstrap ${MOUNTPOINT} grub os-prober
        break
        ;;
      2)
        pacstrap ${MOUNTPOINT} syslinux gptfdisk
        break
        ;;
      3)
        break
        ;;
      4)
        if [[ $UEFI -eq 1 ]]
        then
          pacstrap ${MOUNTPOINT} refind-efi os-prober
          break
        else
          invalid_option
        fi
        ;;
      5)
        [[ $UEFI -eq 1 ]] && break || invalid_option
        ;;
      *)
        invalid_option
        ;;
    esac
  done
  [[ $UEFI -eq 1 ]] && pacstrap ${MOUNTPOINT} efibootmgr dosfstools
}
#}}}
#CONFIGURE BOOTLOADER {{{
configure_bootloader(){
  case $bootloader in
    Grub2)
      print_title "GRUB2 - https://wiki.archlinux.org/index.php/GRUB2"
      print_info "GRUB2 is the next generation of the GRand Unified Bootloader (GRUB).\nIn brief, the bootloader is the first software program that runs when a computer starts. It is responsible for loading and transferring control to the Linux kernel."
      grub_install_mode=("Automatic" "Manual")
      PS3="$prompt1"
      echo -e "Grub Install:\n"
      select OPT in "${grub_install_mode[@]}"; do
        case "$REPLY" in
          1)
            if [[ $LUKS -eq 1 ]]; then
              sed -i -e 's/GRUB_CMDLINE_LINUX="\(.\+\)"/GRUB_CMDLINE_LINUX="\1 cryptdevice=\/dev\/'"${LUKS_DISK}"':crypt"/g' -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cryptdevice=\/dev\/'"${LUKS_DISK}"':crypt"/g' ${MOUNTPOINT}/etc/default/grub
            fi
            if [[ $UEFI -eq 1 ]]; then
              arch_chroot "grub-install --target=x86_64-efi --efi-directory=${EFI_MOUNTPOINT} --bootloader-id=arch_grub --recheck"
            else
              arch_chroot "grub-install --target=i386-pc --recheck --debug ${BOOT_MOUNTPOINT}"
            fi
            break
            ;;
          2)
            arch-chroot ${MOUNTPOINT}
            break
            ;;
          *)
            invalid_option
            ;;
        esac
      done
      arch_chroot "grub-mkconfig -o /boot/grub/grub.cfg"
      ;;
    Syslinux)
      print_title "SYSLINUX - https://wiki.archlinux.org/index.php/Syslinux"
      print_info "Syslinux is a collection of boot loaders capable of booting from hard drives, CDs, and over the network via PXE. It supports the fat, ext2, ext3, ext4, and btrfs file systems."
      syslinux_install_mode=("[MBR] Automatic" "[PARTITION] Automatic" "Manual")
      PS3="$prompt1"
      echo -e "Syslinux Install:\n"
      select OPT in "${syslinux_install_mode[@]}"; do
        case "$REPLY" in
          1)
            arch_chroot "syslinux-install_update -iam"
            if [[ $LUKS -eq 1 ]]; then
              sed -i "s/APPEND root=.*/APPEND root=\/dev\/mapper\/${ROOT_PART} cryptdevice=\/dev\/${LUKS_DISK}:crypt ro/g" ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            elif [[ $LVM -eq 1 ]]; then
              sed -i "s/sda[0-9]/\/dev\/mapper\/${ROOT_PART}/g" ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            else
              sed -i "s/sda[0-9]/${ROOT_PART}/g" ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            fi
            print_warning "The partition in question needs to be whatever you have as / (root), not /boot."
            pause_function
            $EDITOR ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            break
            ;;
          2)
            arch_chroot "syslinux-install_update -i"
            if [[ $LUKS -eq 1 ]]; then
              sed -i "s/APPEND root=.*/APPEND root=\/dev\/mapper\/${ROOT_PART} cryptdevice=\/dev\/${LUKS_DISK}:crypt ro/g" ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            elif [[ $LVM -eq 1 ]]; then
              sed -i "s/sda[0-9]/\/dev\/mapper\/${ROOT_PART}/g" ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            else
              sed -i "s/sda[0-9]/${ROOT_PART}/g" ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            fi
            print_warning "The partition in question needs to be whatever you have as / (root), not /boot."
            pause_function
            $EDITOR ${MOUNTPOINT}/boot/syslinux/syslinux.cfg
            break
            ;;
          3)
            print_info "Your boot partition, on which you plan to install Syslinux, must contain a FAT, ext2, ext3, ext4, or Btrfs file system. You should install it on a mounted directory, not a /dev/sdXY partition. You do not have to install it on the root directory of a file system, e.g., with partition /dev/sda1 mounted on /boot you can install Syslinux in the syslinux directory"
            echo -e $prompt3
            print_warning "mkdir /boot/syslinux\nextlinux --install /boot/syslinux "
            arch-chroot ${MOUNTPOINT}
            break
            ;;
          *)
            invalid_option
            ;;
        esac
      done
      ;;
    Systemd)
      print_title "SYSTEMD-BOOT - https://wiki.archlinux.org/index.php/Systemd-boot"
      print_info "systemd-boot (previously called gummiboot), is a simple UEFI boot manager which executes configured EFI images. The default entry is selected by a configured pattern (glob) or an on-screen menu. It is included with systemd since systemd 220-2."
      print_warning "\tSystemd-boot heavily suggests that /boot is mounted to the EFI partition, not /boot/efi, in order to simplify updating and configuration."
      gummiboot_install_mode=("Automatic" "Manual")
      PS3="$prompt1"
      echo -e "Gummiboot install:\n"
      select OPT in "${gummiboot_install_mode[@]}"; do
        case "$REPLY" in
          1)
            arch_chroot "bootctl --path=${EFI_MOUNTPOINT} install"
            print_warning "Please check your .conf file"
            partuuid=`blkid -s PARTUUID ${ROOT_MOUNTPOINT} | awk '{print $2}' | sed 's/"//g' | sed 's/^.*=//'`
            if [[ $LUKS -eq 1 ]]; then
              echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\ninitrd\t/initramfs-linux.img\noptions\tcryptdevice=\/dev\/${LUKS_DISK}:luks root=\/dev\/mapper\/${ROOT_PART} rw" > ${MOUNTPOINT}/boot/loader/entries/arch.conf
            elif [[ $LVM -eq 1 ]]; then
              echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\ninitrd\t/initramfs-linux.img\noptions\troot=\/dev\/mapper\/${ROOT_PART} rw" > ${MOUNTPOINT}/boot/loader/entries/arch.conf
            else
              echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\ninitrd\t/initramfs-linux.img\noptions\troot=PARTUUID=${partuuid} rw" > ${MOUNTPOINT}/boot/loader/entries/arch.conf
            fi
            echo -e "default  arch\ntimeout  5" > ${MOUNTPOINT}/boot/loader/loader.conf
            pause_function
            $EDITOR ${MOUNTPOINT}/boot/loader/entries/arch.conf
            $EDITOR ${MOUNTPOINT}/boot/loader/loader.conf
            break
            ;;
          2)
            arch-chroot ${MOUNTPOINT}
            break
            ;;
          *)
            invalid_option
            ;;
        esac
      done
      ;;
    rEFInd)
      print_title "REFIND - https://wiki.archlinux.org/index.php/REFInd"
      print_info "rEFInd is a UEFI boot manager capable of launching EFISTUB kernels. It is a fork of the no-longer-maintained rEFIt and fixes many issues with respect to non-Mac UEFI booting. It is designed to be platform-neutral and to simplify booting multiple OSes."
      print_warning "When refind-install (used in Automatic mode) is run in chroot (e.g. in live system when installing Arch Linux) /boot/refind-linux.conf is populated with kernel options from the live system not the one on which it is installed. You need to adjust kernel options in /boot/refind-linux.conf manually."
      refind_install_mode=("Automatic" "Manual")
      PS3="$prompt1"
      echo -e "rEFInd install:\n"
      select OPT in "${refind_install_mode[@]}"; do
        case "$REPLY" in
          1)
            arch_chroot "refind-install"
            $EDITOR ${MOUNTPOINT}/boot/refind_linux.conf
            break
            ;;
          2)
            arch-chroot ${MOUNTPOINT}
            break
            ;;
          *)
            invalid_option
            ;;
        esac
      done
      ;;
  esac
  pause_function
}
#}}}
#ROOT PASSWORD {{{
root_password(){
  print_title "ROOT PASSWORD"
  print_warning "Enter your new root password"
  arch_chroot "passwd"
  pause_function
}
#}}}
#FINISH {{{
finish(){
  print_title "INSTALL COMPLETED"
  print_warning "\nA copy will be placed in /root directory of the new system"
  cp -R `pwd` ${MOUNTPOINT}/root
  read_input_text "Reboot system"
  if [[ $OPTION == y ]]; then
    umount_partitions
    reboot
  fi
  exit 0
}
#}}}

print_title "https://wiki.archlinux.org/index.php/Installation_guide"
print_info "The Arch Install Scripts are a set of Bash scripts that simplify Arch installation."
pause_function
check_boot_system
check_connection
check_trim
pacman -Sy
while true
do
  print_title "ARCHLINUX ULTIMATE INSTALL"
  echo " 1) $(mainmenu_item "${checklist[1]}"  "Select Keymap"            "${KEYMAP}" )"
  echo " 2) $(mainmenu_item "${checklist[2]}"  "Select Editor"            "${EDITOR}" )"
  echo " 3) $(mainmenu_item "${checklist[3]}"  "Configure Mirrorlist"     "${country_name} (${country_code})" )"
  echo " 4) $(mainmenu_item "${checklist[4]}"  "Partition Scheme"         "${partition_layout}: ${partition}(${filesystem}) swap(${swap_type})" )"
  echo " 5) $(mainmenu_item "${checklist[5]}"  "Install Base System")"
  echo " 6) $(mainmenu_item "${checklist[6]}"  "Configure Fstab"          "${fstab}" )"
  echo " 7) $(mainmenu_item "${checklist[7]}"  "Configure Hostname"       "${host_name}" )"
  echo " 8) $(mainmenu_item "${checklist[8]}"  "Configure Timezone"       "${ZONE}/${SUBZONE}" )"
  echo " 9) $(mainmenu_item "${checklist[9]}"  "Configure Hardware Clock" "${hwclock}" )"
  echo "10) $(mainmenu_item "${checklist[10]}" "Configure Locale"         "${LOCALE}" )"
  echo "11) $(mainmenu_item "${checklist[11]}" "Configure Mkinitcpio")"
  echo "12) $(mainmenu_item "${checklist[12]}" "Install Bootloader"       "${bootloader}" )"
  echo "13) $(mainmenu_item "${checklist[13]}" "Root Password")"
  echo ""
  echo " d) Done"
  echo ""
  read_input_options
  for OPT in ${OPTIONS[@]}; do
    case "$OPT" in
      1)
        select_keymap
        checklist[1]=1
        ;;
      2)
        select_editor
        checklist[2]=1
        ;;
      3)
        configure_mirrorlist
        checklist[3]=1
        ;;
      4)
        umount_partitions
        create_partition_scheme
        format_partitions
        checklist[4]=1
        ;;
      5)
        install_base_system
        configure_keymap
        setup_alt_dns
        checklist[5]=1
        ;;
      6)
        configure_fstab
        checklist[6]=1
        ;;
      7)
        configure_hostname
        checklist[7]=1
        ;;
      8)
        configure_timezone
        checklist[8]=1
        ;;
      9)
        configure_hardwareclock
        checklist[9]=1
        ;;
      10)
        configure_locale
        checklist[10]=1
        ;;
      11)
        configure_mkinitcpio
        checklist[11]=1
        ;;
      12)
        install_bootloader
        configure_bootloader
        checklist[12]=1
        ;;
      13)
        root_password
        checklist[13]=1
        ;;
      "d")
        finish
        ;;
      *)
        invalid_option
        ;;
    esac
  done
done
# }}}

# vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker smc=90 :
