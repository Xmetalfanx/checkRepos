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
    #metaCheckArch

    # Debian 
    #metaDebianCheck ${package}

    # Fedora 
    #get_fedora_info "${package}"

    # OpenSUSE 
    get_openSUSE_repo_urls "leap155" "${package}"
    get_openSUSE_repo_urls "tumbleweed" "${package}"

    # Ubuntu
    #checkUbuntuRepos ${package}

}

metaCheckRepos "hexchat"

# known "false" for test 
#metaCheckRepos "foowolf"


#metaCheckRepos "libgtk-4"