#!/bin/bash
. configs/common.cfg
. configs/archrelated.cfg
. configs/multidistro.cfg
. configs/ubunturelated.cfg


# For Debian, Fedora, and OpenSUSE
function checkMultiDistros() {
    echo -e "Checking ${distro} for ${package}"

    # how do i check using the package URL ... like in each distro's search do i search the webpage for "file not found"?

        # fedora may say "No results found!" or have "did you mean ..."

}

# Meta function
# I need to make sure i look for exact names in my search, I think 
function metaCheckRepos() {

    package=$1

    clear
    echo -e "Checking Arch, Debian, Fedora, OpenSUSE, and Ubuntu repos for ${package}"

    metaCheckArch

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

    checkUbuntuRepos ${package}

}

#metaCheckRepos "shunar"
metaCheckRepos "librewolf"
# test to check aur with
metaCheckRepos "foowolf"
#metaCheckRepos "libgtk-4"