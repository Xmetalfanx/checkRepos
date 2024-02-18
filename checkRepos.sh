#!/bin/bash
. configs/common.cfg
. configs/archrelated.cfg
. configs/debianrelated.cfg
. configs/multidistro.cfg
. configs/ubunturelated.cfg

userPrompt 

# Meta function
# I need to make sure i look for exact names in my search, I think 
function metaCheckRepos() {

    package=$1

    clear
    echo -e "Checking Arch, Debian, Fedora, OpenSUSE, and Ubuntu repos for ${package}"

    #metaCheckArch

    metaDebianCheck ${package}


    # distro="Debian"
    # packageURL="https://packages.debian.org/search?keywords=${package}&searchon=names&suite=stable&section=all"
    # checkMultiDistros

    # distro="Fedora"
    # packageURL="https://packages.fedoraproject.org/search?query=${package}"
    # checkMultiDistros ${distro} ${packageURL}

    # distro="OpenSUSE"
    # # do different openSUSE Branches
    # packageURL="https://software.opensuse.org/package/${package}"
    # checkMultiDistros

    #checkUbuntuRepos ${package}

}

metaCheckRepos "firefox-esr"

# known "false" for test 
metaCheckRepos "foowolf"


#metaCheckRepos "libgtk-4"