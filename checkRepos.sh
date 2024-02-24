#!/bin/bash
. configs/common.cfg
. configs/archrelated.cfg
. configs/debianrelated.cfg
. configs/fedorarelated.cfg
. configs/opensuserelated.cfg
. configs/ubunturelated.cfg

# for debugging
#userPrompt

# Meta function
# I need to make sure i look for exact names in my search, I think
function meta_check_repos() {

    package=${1}

    clear
    echo -e "Checking Arch, Debian, Fedora, OpenSUSE, and Ubuntu repos for ${package}"

    # Arch
    check_arch_repo "${package}"

    # Debian
    check_debian_repos "${package}"

    # Fedora
    check_fedora_repo "${package}"

    # OpenSUSE
    check_openSUSE_repo "15.5" "${package}"
    check_openSUSE_repo "15.6" "${package}"
    check_openSUSE_repo "tumbleweed" "${package}"

    # Ubuntu
    check_ubuntu_repos ${package}

}

meta_check_repos "hexchat"
#meta_check_repos "MozillaFirefox"


#meta_check_repos "firefox"

#meta_check_repos "curl"


#meta_check_repos "libgtk-4"