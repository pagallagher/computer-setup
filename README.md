# Fresh Computer Data Science Setup

Here is my step by step process of setting up new computers. I lean toward Ubuntu derivatives for simplicity because there's less dealing with the annoying parts of the Linux underbelly. It more or less just comes down to personal preference on UI, since by and large most of the derivatives are functionally identical.

A handful of things in here will be somewhat specific to Linux Mint. I will flag as such.

## Tweaks

The goal here is to limit the amout of logging that goes on because by default it's a bit excessive.
```
#systemd cleanup
sudo journalctl --vacuum-size=50M
sudo sed -i 's/#SystemMaxFiles=100/SystemMaxFiles=5/g' /etc/systemd/journald.conf
sudo sed -i 's/#SystemMaxFileSize=/SystemMaxFileSize=1G/g' /etc/systemd/journald.conf
sudo sed -i 's/#Storage=auto/Storage=none/g' /etc/systemd/journald.conf

#logging cleanup
sudo ufw logging off
sudo sed -i 's/rotate 7/rotate 1/g' /etc/logrotate.d/rsyslog
sudo sed -i 's/rotate 4/rotate 1/g' /etc/logrotate.d/rsyslog
sudo sed -i 's/weekly/daily/g' /etc/logrotate.d/rsyslog
sudo sed -i 's/rotate 4/rotate 1/g' /etc/logrotate.conf
sudo sed -i 's/weekly/daily/g' /etc/logrotate.conf
```

## Install Necessary Software

Pick and choose as desired. Note, I also have an emacs for python config file that may or may not be of interest.
```bash
# Compilers
sudo apt-get install g++
sudo apt-get install build-essential

# Password Manager
sudo add-apt-repository ppa:eugenesan/ppa
sudo apt-get update
sudo apt-get install keepassx

# Iridium Browser
wget -qO - https://downloads.iridiumbrowser.de/ubuntu/iridium-release-sign-01.pub|sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/iridium-browser.list
deb [arch=amd64] https://downloads.iridiumbrowser.de/deb/ stable main
#deb-src https://downloads.iridiumbrowser.de/deb/ stable main
EOF
sudo apt-get update
sudo apt-get install iridium-browser

#Miniconda (Python)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# Emacs
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26
cp init.el ~/.emacs.d/init.el

# R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt update
sudo apt install r-base
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.1578-amd64.deb
sudo dpkg -i rstudio-1.2.1578-amd64.deb
sudo apt-get install unbound
```

## Remove Preinstalled Software

This section is very dependant on the Linux flavor chosen. I would read through this section carefully. If you happen to want anything in here, remove it before running. If there are additional things that you want to dispose of, add them.

I also disable bluetooth here to help battery life. If you actually use bluetooth, skip that section.

I also remove a lot of the language specific character fonts that I don't speak.
```bash
# Unused Programs
sudo apt-get purge hexchat firefox thunderbird seahorse
rm -f ~/.mozilla/firefox/
rm -f ~/.macromedia/ 
rm -f ~/.adobe
sudo rm -f /etc/firefox/
sudo rm -f /usr/lib/firefox/
sudo apt-get autoremove

# Disable bluetooth
sudo systemctl disable bluetooth.service
sudo systemctl disable bluetooth --now


# Assorted fonts
sudo apt-get remove "fonts-kacst*" "fonts-khmeros*" fonts-lklug-sinhala fonts-guru-extra "fonts-nanum*" fonts-noto-cjk "fonts-takao*" fonts-tibetan-machine fonts-lao fonts-sil-padauk fonts-sil-abyssinica "fonts-tlwg-*" "fonts-lohit-*" fonts-beng-extra fonts-gargi fonts-gubbi fonts-gujr-extra fonts-kalapi "fonts-samyak*" fonts-navilu fonts-nakula fonts-orya-extra fonts-pagul fonts-sarai "fonts-telu*" "fonts-wqy*" "fonts-smc*" fonts-deva-extra fonts-sahadeva
sudo dpkg-reconfigure fontconfig
```

## Final Cleanup

Just installing any packages that were missed and making sure everything is up to date.

```bash
sudo apt-get --fix-broken install
sudo apt update
sudo apt upgrade
```
