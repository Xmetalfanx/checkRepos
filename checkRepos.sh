# check status of last command ... if successful that means there is a match 
function userPrompt() {
  read -r -p "Press [Enter] to continue"
  clear 
}

function checkForMatch() {
    # for arch anyway ... refactor later if needed
    # reminder: -z is "is length of string zero?"  returns true if it IS zero


    # NOT SURE how i did this but in the checkRepo var there is a "not found" check
    #  ... if that IS present (non zero length string, the package is not found)
    [ -z "${checkRepo}" ] && echo "${package} found" && package_exists="true" || echo "${package} not found" || package_exists="false"
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
        false) echo "Package doesn't exist, nothing to do or report";;

        true) 
                #echo -e "debugging: packageURL:\t${packageURL}"

                package_version=$(curl -Ls ${packageURL} | grep -m1 -E "<td>[0-9]*\." | sed 's/<td>//;s/<.td>//' | tr -d \[:blank:] )
                echo -e "Arch version for ${package} is: ${package_version}" 
            ;;

    esac 

    # AUR
#     packageURL="https://aur.archlinux.org/packages/?O=0&K=${package}"
#     checkRepo=$(curl -Ls "${packageURL}" | echo "checks here" )
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

    checkArchRepo

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

#metaCheckRepos "shunar"
metaCheckRepos "smplayer"
#metaCheckRepos "libgtk-4"