#!/bin/bash

# check status of last command ... if successful that means there is a match 
function userPrompt() {
  read -r -p "Press [Enter] to continue"
  #clear 
}

function clear_vars() {
    unset "${package}" "${package_url}" "${aur_check}" "${aur_version}" 
}


function checkForMatch() {
    # for arch anyway ... refactor later if needed
    # reminder: -z is "is length of string zero?"  returns true if it IS zero

    # NOT SURE how i did this but in the checkRepo var there is a "not found" check
    #  ... if that IS present (non zero length string, the package is not found)

    ## thought: do i really need/want an echo here? was that for debugging?
    [ -z "${checkRepo}" ] && package_exists="true" || package_exists="false"
}

function checkAUR() {
    # AUR
    # idea: aur should be exact package match 
    packageURL="https://aur.archlinux.org/packages/${package}"
    aur_check=$(curl -Ls "${packageURL}" )
    
    [[ ${aur_check} = *"404 - Page Not Found"* ]] && echo -e "Package ${package} not found in AUR" && userPrompt && return || aur_version=$(curl -Ls "${packageURL}" | awk '/Package Details/ { print $4}' | cut -d "<" -f1 ) && echo -e "${package} version in the AUR is ${aur_version}" 

    clear_vars && userPrompt

}

# check Repos for package
function checkArchRepo() {
    distro="arch"
    echo -e "Checking ${distro} for ${package}"

    # pacman
    #packageURL="https://www.archlinux.org/packages/${package}"
    packageURL="https://archlinux.org/packages/?q=${package}"
    checkRepo=$(curl -sL "${packageURL}" | grep "No matching packages found" )
    
    #only checks to see if its found 
    checkForMatch

    case $package_exists in 
        false) echo "Package ${package} doesn't exist in the default Arch repos" ;;

        true) 
            package_version=$(curl -Ls ${packageURL} | grep -m1 -E "<td>[0-9]*\." | sed 's/<td>//;s/<.td>//' | tr -d \[:blank:] )
            echo -e "Arch version for ${package} is: ${package_version}" 
            ;;

    esac 

    userPrompt

}

function metaCheckArch() {
    checkArchRepo

    checkAUR
}

function checkUbuntuRepos() {
    clear 
    echo -e "Checking Ubuntu for ${package}"
    # work with different branches here I may have to use different URLs here that have each branch in the name
    packageURL="https://packages.ubuntu.com/search?keywords=${package}&searchon=names&suite=disco&section=all"

    checkRepo=$(curl -Ls "${packageURL}")

    # ?? i think i may need SPECIFIC links for say each branch? 
    focal_url="https://packages.ubuntu.com/focal/${package}"
    focal_result=$(curl -Ls "${focal_url}" | awk '/Package:/ {print $3}' | sed 's/(//;s/)//')


    [ -z "$focal_result" ] && echo -e "${package} not found in Ubuntu focal repo" || echo -e "Focal result for ${package}:\t${focalResult}"

    jammy_url="https://packages.ubuntu.com/jammy/${package}"
    jammy_result=$(curl -Ls "${jammy_url}" | awk '/Package:/ {print $3}' | sed 's/(//;s/)//')

    [ -z "$jammy_result" ] && echo -e "${package} not found in Ubuntu jammy repo" || echo -e "Jammy result for ${package}:\t${jammy_result}"

    userPrompt
}

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