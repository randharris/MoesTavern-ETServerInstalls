#!/bin/bash
# Author:  MaxPower - notoriusmax@gmail.com
# GitHub:  https://github.com/randharris/MoesTavern-ETServerInstalls/blob/main/etLegacySetupLibrary.sh

# Update the server (assumes Ubuntu 20.xx & >)
function updateServer() {
    sudo apt update
    sudo apt -y upgrade
}

# needed to extract compressed Files
function installUnzip() {
    sudo apt-get install -y unzip
}

# installation of ETL and server configs
function installET() {
    # variable to store user input
    local servername=${1}
    local g_password=${2}
    local sv_maxclients=${3}
    local sv_privateclients=${4}
    local sv_privatepassword=${5}
    local rconpassword=${6}
    local refereepassword=${7}
    local sv_wwwBaseURL=${8}
    mkdir -p ~/et/
    mkdir -p /tmp/etsetup
    cd /tmp/etsetup
    wget http://moestavern.site.nfoservers.com/downloads/server/etlegacy-v2.78.0-x86_64.sh
    sudo chmod +x etlegacy-v2.78.0-x86_64.sh
    yes | ./etlegacy-v2.78.0-x86_64.sh --skip-license
    rsync -a /tmp/etsetup/* ~/et/
    wget https://cdn.splashdamage.com/downloads/games/wet/et260b.x86_full.zip
    unzip et260b.x86_full.zip
    ./et260b.x86_keygen_V03.run --noexec --target /tmp/etsetup/extracted
    rsync -a extracted/* ~/et/
    rm -rf /tmp/etsetup
    cd ~/et/
    mkdir -p ~/et/legacy/configs
    cd /legacy/configs
    wget http://moestavern.site.nfoservers.com/downloads/server/legacy_global_configs.zip
    unzip legacy_global_configs.zip
    rm -rf legacy_global_configs.zip
    cd ..
    cd ..
    cd etmain/
    wget http://moestavern.site.nfoservers.com/downloads/server/config/etlscrimrotation.cfg
    wget http://moestavern.site.nfoservers.com/downloads/server/config/etl_server.cfg -O etl_server.cfg
    sudo sed -i 's/set sv_hostname ""/set sv_hostname '"\"${servername}\""'/' etl_server.cfg
    sudo sed -i 's/set g_password ""/set g_password '"\"${g_password}\""'/' etl_server.cfg
    sudo sed -i 's/set sv_maxclients ""/set sv_maxclients '"\"${sv_maxclients}\""'/' etl_server.cfg
    sudo sed -i 's/set sv_privateclients ""/set sv_privateclients '"\"${sv_privateclients}\""'/' etl_server.cfg
    sudo sed -i 's/set sv_privatepassword ""/set sv_privatepassword '"\"${sv_privatepassword}\""'/' etl_server.cfg
    sudo sed -i 's/set rconpassword ""/set rconpassword '"\"${rconpassword}\""'/' etl_server.cfg
    sudo sed -i 's/set refereepassword ""/set refereepassword '"\"${refereepassword}\""'/' etl_server.cfg
    sudo sed -i 's#set sv_wwwBaseURL ""#set sv_wwwBaseURL '"\"${sv_wwwBaseURL}\""'#' etl_server.cfg
    cd ..
}

# installation of maps for ETL
function installMaps() {
    cd etmain/
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/adlernest.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/etl_adlernest_v1.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/braundorf_b4.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/bremen_b3.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/crevasse_b3.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/ctf_multi.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/decay_sw.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/element_b4_1.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/erdenberg_t1.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/et_ice.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/et_ufo_final.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/frostbite.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/karsiah_te2.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/missile_b3.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/osiris_final.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/reactor_final.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/rifletennis_te.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/rifletennis_te2.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/sos_secret_weapon.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/sp_delivery_te.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/supply.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/etl_supply_v5.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/sw_battery.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/sw_goldrush_te.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/sw_oasis_b3.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/tc_base.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/te_escape2.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/te_valhalla.pk3
    wget http://moestavern.site.nfoservers.com/downloads/et/etmain/venice_ne4.pk3
    cd ..
}

# downloads and places the start script for ETL which includes game path, port, etc.
function configureStartScript() {
    cd ~/et/
    wget http://moestavern.site.nfoservers.com/downloads/server/etl_start.sh
    chmod +x ~/et/etl_start.sh
}

# downloads and places the systemd linux service that runs ETL.  Stop, Stop, Restart, and enabled on Startup.
function configureETLService() {
    cd ~/et/
    wget http://moestavern.site.nfoservers.com/downloads/server/etlserver.service
    mv etlserver.service /etc/systemd/system/etlserver.service
    sudo systemctl daemon-reload
    sudo systemctl enable etlserver.service
}

# Add the new user account for FTP access
# Arguments:
#   Account Username
function addUserAccount() {
    # variable to store user input
    local username=${1}
    # create new user account from input
    sudo useradd "${username}"
    # set password for new user.  will prompt for input and confirmation. do not want to read plain text as it will cypher to /etc/passwd
    setFTPUserPass "${username}"
    # disable new user from being able to ssh into the server
    echo "DenyUsers ${username}" | sudo tee -a /etc/ssh/sshd_config
    sudo systemctl restart sshd
}

function setFTPUserPass() {
    # variable to store user input
    local username=${1}
    # set password for new user.  will prompt for input and confirmation. do not want to read plain text as it will cypher to /etc/passwd
    sudo passwd "${username}"
}

# installs and configures VSFTPD
function configureVSFTP() {
    sudo apt install -y vsftpd
    cd ~/et/
    wget http://moestavern.site.nfoservers.com/downloads/server/vsftpd.conf
    mv vsftpd.conf /etc/vsftpd.conf
    # set FTP permissions for new user
    sudo usermod -d ~/et/ "${username}"
    sudo chown -R "${username}":"${username}" ~/
    sudo systemctl restart vsftpd
}

# configures the firewall for FTP and ETL
function configureUFW() {
    sudo ufw allow 20/tcp
    sudo ufw allow 21/tcp
    sudo ufw allow OpenSSH
    sudo ufw allow 40000:50000/tcp
    sudo ufw allow 990/tcp
    sudo ufw allow 27960/udp
    yes | sudo ufw enable
}
