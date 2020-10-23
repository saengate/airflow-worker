FROM backend

WORKDIR /tmp
COPY ./ansible ./ansible

WORKDIR /tmp/ansible
RUN service ssh start && ssh-keyscan -H localhost >> ~/.ssh/known_hosts && ansible-playbook config-django.yml

WORKDIR /webapps/django
EXPOSE 22 7000 7001

CMD [   "bash",                         \
    "-c",                           \
    "service supervisor start &&    \
    supervisorctl reread &&         \
    supervisorctl update &&         \
    supervisorctl start all &&      \
    service ssh start &&            \
    /bin/bash"                      \
    ]
