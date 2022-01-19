FROM bitnami/owncloud:10.8.0
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git sudo

RUN git clone -b tf-owncloud-10.8.0 https://github.com/crystaluniverse/tf-owncloud.git
RUN cp -rf tf-owncloud/core /opt/bitnami/owncloud/
RUN cp -rf tf-owncloud/lib  /opt/bitnami/owncloud/

# mariadb installation
ENV HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux"

# Install required system packages and dependencies
RUN install_packages acl ca-certificates curl gzip libaio1 libaudit1 libc6 libcap-ng0 libgcc1 libicu63 liblzma5 libncurses6 libpam0g libssl1.1 libstdc++6 libtinfo6 libxml2 procps psmisc tar zlib1g
COPY rootfs /
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "ini-file" "1.4.1-1" --checksum d7c3c81138361e10e6ddd7eae3ac323740a8477ce395a8c00ab0dba76fd25948
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "mariadb" "10.5.13-1" --checksum a26f5ca1054131425097c346f0572d0c17be9a3f390baddaf1d8fff9d1529bfd
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "gosu" "1.14.0-1" --checksum 16f1a317859b06ae82e816b30f98f28b4707d18fe6cc3881bff535192a7715dc
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami
RUN mkdir /docker-entrypoint-initdb.d

RUN /opt/bitnami/scripts/mariadb/postunpack.sh
ENV BITNAMI_APP_NAME="mariadb" \
    BITNAMI_IMAGE_VERSION="10.5.13-debian-10-r65" \
    PATH="/opt/bitnami/common/bin:/opt/bitnami/mariadb/bin:/opt/bitnami/mariadb/sbin:$PATH" \
    MARIADB_USER=bn_owncloud \
    MARIADB_PASSWORD=bn_owncloud \
    MARIADB_DATABASE=bitnami_owncloud \
    MARIADB_ROOT_PASSWORD=bn_owncloud 

USER root

# for owncloud
ENV OWNCLOUD_DATABASE_HOST=mariadb
ENV OWNCLOUD_DATABASE_PORT_NUMBER=3306
ENV OWNCLOUD_DATABASE_USER=bn_owncloud
ENV OWNCLOUD_DATABASE_NAME=bitnami_owncloud
ENV OWNCLOUD_DATABASE_PASSWORD=bn_owncloud
# ALLOW_EMPTY_PASSWORD is recommended only for development.
# ENV ALLOW_EMPTY_PASSWORD=yes
# Host for accessing ownCloud
# note: this setting will only be applied on the first run
# ref: https://github.com/bitnami/bitnami-docker-owncloud#configuration
ENV OWNCLOUD_HOST=localhost
ENV OWNCLOUD_USERNAME=user
ENV OWNCLOUD_PASSWORD=admin
ENV OWNCLOUD_EMAIL=user@example.com
ENV OWNCLOUD_ALLOW_EMPTY_PASSWORD=no

EXPOSE 3306 8080 8443
RUN chmod +x /opt/bitnami/scripts/owncloud/entrypoint.sh && chmod +x /opt/bitnami/scripts/owncloud/run.sh
ENTRYPOINT [ "/opt/bitnami/scripts/owncloud/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/owncloud/run.sh" ]