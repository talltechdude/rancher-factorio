#!/bin/bash

saveFile="/opt/factorio/saves/$FACTORIO_SAVE_NAME.zip"
rm -f saveFile
if [[ ! -f $saveFile ]]; then
    bin/x64/factorio --create $saveFile --map-gen-settings /opt/factorio/config/map-gen-settings.json
fi

params="--start-server $saveFile"
params="$params --mod-directory /opt/factorio/mods"
params="$params --server-settings /opt/factorio/config/server-settings.json"
if [[ ! -z "$FACTORIO_PORT" ]]; then
    params = "$params --port $FACTORIO_PORT"
fi

exec bin/x64/factorio $params
