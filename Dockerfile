FROM debian:unstable-slim

RUN apt-get update && apt-get install -y \
    dovecot-core \
    dovecot-imapd \
    dovecot-ldap \
    getmail4 \
    cron \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i -e "s/#disable_plaintext_auth = yes/disable_plaintext_auth = no/" /etc/dovecot/conf.d/10-auth.conf \
 && sed -i -e "s/auth_mechanisms = plain/auth_mechanisms = plain login/" /etc/dovecot/conf.d/10-auth.conf \
 && sed -i -e "s/mail_location = mbox:~\/mail:INBOX=\/var\/mail\/%u/mail_location = maildir:~\/Maildir/" /etc/dovecot/conf.d/10-mail.conf

EXPOSE 143 993

COPY skel/ /etc/skel/

ADD dovecot_useradd.sh /dovecot_useradd.sh
RUN chmod 775 /dovecot_useradd.sh

ADD cron-getmail.sh /cron-getmail.sh
RUN chmod 775 /cron-getmail.sh

ADD crond.getmail /etc/cron.d/getmail
RUN chmod 644 /etc/cron.d/getmail

ADD entrypoint.sh /entrypoint.sh
RUN chmod 775 /entrypoint.sh

CMD /usr/sbin/service cron start && tail -f /dev/null

ENTRYPOINT ["/entrypoint.sh"]
