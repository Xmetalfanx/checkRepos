#!/bin/bash
. configs/common.cfg
. configs/archrelated.cfg
. configs/debianrelated.cfg
. configs/fedorarelated.cfg
. configs/opensuserelated.cfg
. configs/ubunturelated.cfg


# Meta function
# I need to make sure i look for exact names in my search, I think
function metaCheckRepos() {

    package=${1}

    clear
    echo -e "Checking Arch, Debian, Fedora, OpenSUSE, and Ubuntu repos for ${package}"

    # Arch
    checkArchRepo "${package}"

    # Debian
    checkDebianRepos "${package}"

    # Fedora
    checkFedoraRepos "${package}"

    # OpenSUSE
    checkOpenSUSERepos "leap155" "${package}"
    checkOpenSUSERepos "tumbleweed" "${package}"

    # Ubuntu
    checkUbuntuRepos ${package}

}

metaCheckRepos "hexchat"

#metaCheckRepos "firefox"


#metaCheckRepos "libgtk-4"