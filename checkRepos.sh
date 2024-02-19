#!/bin/bash
. configs/common.cfg
. configs/archrelated.cfg
. configs/debianrelated.cfg
. configs/fedorarelated.cfg
. configs/multidistro.cfg
. configs/ubunturelated.cfg


# Meta function
# I need to make sure i look for exact names in my search, I think 
function metaCheckRepos() {

    package=$1

    clear
    echo -e "Checking Arch, Debian, Fedora, OpenSUSE, and Ubuntu repos for ${package}"

    #metaCheckArch

    #metaDebianCheck ${package}

    get_fedora_info "${package}"

    # distro="OpenSUSE"
    # # do different openSUSE Branches
    # packageURL="https://software.opensuse.org/package/${package}"
    # checkMultiDistros

    #checkUbuntuRepos ${package}

}

metaCheckRepos "zsh"

# known "false" for test 
 metaCheckRepos "foowolf"


#metaCheckRepos "libgtk-4"