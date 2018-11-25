
distro=$(grep "^ID_LIKE=" /etc/os-release  | cut -f2 -d=)

if [[ "${distro}" == "debian" ]]; then
  . ~/.bashrc_ubuntu
else
  . ~/.bashrc_rhel
fi
if [ -e ~/.bashrc_extra ]; then
  . ~/.bashrc_extra
fi
