###########################################################
# Dockerfile that builds a Stationeers Dedicated Server
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="cr4sh@tuamadresadimiele.it"

ENV STEAMAPPID 600760
ENV STEAMAPP stationeers
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY entry.sh "${HOMEDIR}/entry.sh"

RUN set -x \
        # Install, update & upgrade packages
        && apt-get update \
        && apt-get install -y --no-install-recommends --no-install-suggests \
                wget=1.21-1+deb11u1 \
                ca-certificates=20210119 \
                lib32z1=1:1.2.11.dfsg-2+deb11u1 \
        && mkdir -p "${STEAMAPPDIR}" \
        # Add entry script
        && { \
                echo '@ShutdownOnFailedCommand 1'; \
                echo '@NoPromptForPassword 1'; \
                echo 'force_install_dir '"${STEAMAPPDIR}"''; \
                echo 'login anonymous'; \
                echo 'app_update '"${STEAMAPPID}"''; \
                echo 'quit'; \
           } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
        && chmod +x "${HOMEDIR}/entry.sh" \
        && chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \
        # Clean up
        && rm -rf /var/lib/apt/lists/*

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 27015/tcp \
        27015/udp \
        27016/udp
