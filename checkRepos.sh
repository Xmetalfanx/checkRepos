# check status of last command ... if successful that means there is a match 
function userPrompt() {
  read -r -p "Press [Enter] to continue"
  clear 
}

function checkForMatch() {
    # for arch anyway ... refactor later if needed
    [ -z "${checkRepo}" ] && echo "${package} found" || echo "${package} not found"
}


# check Repos for package
function checkArchRepo() {
    distro="arch"
    echo -e "Checking ${distro} for ${package}"

    # pacman
    #packageURL="https://www.archlinux.org/packages/${package}"
    packageURL="https://archlinux.org/packages/?q=${package}"
    checkRepo=$(curl -sL "${packageURL}" | grep "No matching packages found" )
    #echo -e "This should only display something if NO matches are found;\t ${checkRepo}"
    checkForMatch
    
    # AUR
    packageURL="https://aur.archlinux.org/packages/?O=0&K=${package}"
    checkRepo=$(curl -Ls "${packageURL}" | echo "checks here" )
}

function checkUbuntuRepos() {

    echo -e "Checking Ubuntu for ${package}"
    # work with different branches here I may have to use different URLs here that have each branch in the name
    #packageURL="https://packages.ubuntu.com/search?keywords=${1}&searchon=names&suite=disco&section=all"

    #checkRepo=$(curl -Ls "${packageURL}")

    # ?? i think i may need SPECIFIC links for say each branch? 
    focal_url="https://packages.ubuntu.com/focal/${package}"
    focalResult=$(curl -Ls $focal_url | awk '/Package:/ {print $3}' | sed 's/(//;s/)//')
    echo -e "Focal result for ${package}:\t${focalResult}"

    jammy_url="https://packages.ubuntu.com/jammy/${package}"
    jammy_result=$(curl -Ls $jammy_url | awk '/Package:/ {print $3}' | sed 's/(//;s/)//')
    echo -e "Jammy result for ${package}:\t${jammy_result}"

    # debug
    echo -e "${checkRepo}"
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

    #checkArchRepo

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
metaCheckRepos "hexchat"
#metaCheckRepos "libgtk-4"