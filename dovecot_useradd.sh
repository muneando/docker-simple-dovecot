#!/bin/bash
# Add user from dovecot
#

if [ $# -eq 0 ]; then
  echo "Usage dovecot_useradd id [password] [mail_password] [mail_domain]" 1>&2
  exit 1
fi

DEFAULT_PASSWORD=${2:-$DEFAULT_PASSWORD}
MAIL_PASSWORD=${3:-$MAIL_PASSWORD}
MAIL_DOMAIN=${4:-$MAIL_DOMAIN}

useradd --groups=users --shell='/bin/bash' --create-home "$1"
echo -e "$DEFAULT_PASSWORD\n$DEFAULT_PASSWORD\n" | passwd "$1"
sed -i -e "s/USER/$1/" /home/$1/.getmail/getmailrc
sed -i -e "s/MAIL_DOMAIN/$MAIL_DOMAIN/" /home/$1/.getmail/getmailrc
sed -i -e "s/MAIL_PASSWORD/$MAIL_PASSWORD/" /home/$1/.getmail/getmailrc

chmod 0700 /home/$1/.getmail/getmailrc

exit 0