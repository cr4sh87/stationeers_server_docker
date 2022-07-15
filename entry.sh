#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
                                +login anonymous \
                                +app_update "${STEAMAPPID}" \
                                +quit

# Believe it or not, if you don't do this srcds_run shits itself
cd "${STEAMAPPDIR}"

        # if autoexec is present, drop overwritten arguments here (example: SRCDS_PW & SRCDS_RCONPW)
${STEAMAPPDIR}/rocketstation_DedicatedServer.x86_64 -loadlatest "Ucosu" moon -settings ServerName "ocroPoiD" ServerVisible true GamePort 27016 UpdatePort 27015 AutoSave true SaveInterval 300 ServerPassword abc123
