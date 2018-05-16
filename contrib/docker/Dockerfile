FROM debian:jessie
MAINTAINER pavik - https://github.com/pavik

ENV OPCX_VERSION=1.0.0 \
 OPCX_USER=opcx

ENV OPCX_URL=https://github.com/OPCoinX/OPCoinX/releases/download/v$OPCX_VERSION-linux/OPCoinX-$OPCX_VERSION-x86_64-linux-gnu.tar.gz \
 OPCX_CONF=/home/$OPCX_USER/.OPCoinX/OPCoinX.conf \
 OPCX_CONF_URL=https://raw.githubusercontent.com/OPCoinX/OPCoinX/master/OPCoinX.conf

RUN apt-get -qq update && \
apt-get install -yq wget ca-certificates pwgen && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
wget $OPCX_URL -O /tmp/opcx.tar.gz && \
mkdir -p /opt && \
cd /opt && \
tar xvzf /tmp/opcx.tar.gz && \
rm /tmp/opcx.tar.gz && \
ln -sf opcx-$OPCX_VERSION opcx && \
ln -sf /opt/opcx/bin/opcxd /usr/local/bin/opcxd && \
ln -sf /opt/opcx/bin/opcx-cli /usr/local/bin/opcx-cli && \
ln -sf /opt/opcx/bin/opcx-tx /usr/local/bin/opcx-tx && \
adduser --uid 1000 --system ${OPCX_USER} && \
mkdir -p /home/${OPCX_USER}/.OPCoinX/ && \
chown -R ${OPCX_USER} /home/${OPCX_USER} && \
echo "success: $OPCX_CONF"

USER opcx
RUN wget $OPCX_CONF_URL -O $OPCX_CONF && \
    sed -i -e 's/\*your$username\*/opcx/g' ${OPCX_CONF} && \
    sed -i -e 's/\*your$password\*/'`pwgen 32 1`'/g' ${OPCX_CONF} && \
    echo "Success"

EXPOSE 51572
VOLUME ["/home/opcx/.OPCoinX"]
WORKDIR /home/opcx

ENTRYPOINT ["/usr/local/bin/opcxd"]