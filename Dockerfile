FROM registry.redhat.io/openshift4/ose-ansible-operator:v4.10

COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible
RUN curl "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz" -o oc.tar.gz && tar xzf oc.tar.gz && mv oc /usr/local/bin && chmod +x /usr/local/bin/oc && rm oc.tar.gz

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
