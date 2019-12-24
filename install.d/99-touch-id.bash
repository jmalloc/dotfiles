if ! grep -q pam_tid /etc/pam.d/sudo; then
    echo "Enabling TouchID for sudo..."
    sudo sed -i.bak $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo
fi
