UPDATE_URL="https://raw.githubusercontent.com/jchrisfarris/msm/master"
wget -q ${UPDATE_URL}/installers/common.sh -O /tmp/msmcommon.sh
source /tmp/msmcommon.sh && rm -f /tmp/msmcommon.sh

function update_system_packages() {
    install_log "Updating sources"
    sudo yum update -y --skip-broken || install_error "Couldn't update packages"
}

function install_dependencies() {
    install_log "Installing required packages"
    sudo yum install -y screen rsync zip java jq || install_error "Couldn't install dependencies"
}

function enable_init() {
    install_log "Enabling automatic startup and shutdown"
    sudo chkconfig --add msm
}

# predefine these answers before doing the headless install
msm_dir=/home/msm
msm_user=minecraft
msm_user_system=true

add_minecraft_user
update_system_packages
install_dependencies
create_msm_directories
download_latest_files
patch_latest_files
install_config
install_cron
install_init
enable_init
update_msm
setup_jargroup
install_complete