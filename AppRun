#!/bin/sh

HERE="$(dirname "$(readlink -f "${0}")")"

unset GTK_MODULES

export UNION_PRELOAD="${HERE}"
export LD_PRELOAD="${HERE}/libunionpreload.so"

export GCONV_PATH="$HERE/usr/lib/x86_64-linux-gnu/gconv"
export FONTCONFIG_FILE="$HERE/etc/fonts/fonts.conf"

for dir in "$HERE/app/lib/"*/; do
  export LIBRARY_PATH="$dir":$LIBRARY_PATH
done

export LIBRARY_PATH="$HERE/app/lib":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/usr/lib":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/lib":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/usr/lib/i386-linux-gnu":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/lib/i386-linux-gnu":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/usr/lib/i386-linux-gnu/pulseaudio":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/usr/lib/i386-linux-gnu/alsa-lib":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/usr/lib/x86_64-linux-gnu":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/lib/x86_64-linux-gnu":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/usr/lib/x86_64-linux-gnu/pulseaudio":$LIBRARY_PATH
export LIBRARY_PATH="$HERE/usr/lib/x86_64-linux-gnu/alsa-lib":$LIBRARY_PATH
export LIBRARY_PATH="$LIBRARY_PATH":"${LD_LIBRARY_PATH}"

export GSETTINGS_SCHEMA_DIR="$HERE/app/share/glib-2.0/schemas/":"$HERE/app/share/runtime-schemas/":"${GSETTINGS_SCHEMA_DIR}"
export GI_TYPELIB_PATH=$HERE/app/lib/girepository-1.0

export XDG_DATA_DIRS="${HERE}"/usr/share/:"${XDG_DATA_DIRS}"
export TCL_LIBRARY="${HERE}"/usr/share/tcltk/tcl8.6:$TCL_LIBRARY:$TK_LIBRARY
export TK_LIBRARY="${HERE}"/usr/share/tcltk/tk8.6:$TK_LIBRARY:$TCL_LIBRARY

MAIN="$HERE/app/bin/"$(cat "${HERE}/command")

[ -f "$HERE/interpreter" ] && {
  MAIN="$HERE/$(cat ${HERE}/interpreter) ${MAIN}"
}

exec "${HERE}/lib64/ld-linux-x86-64.so.2" --inhibit-cache --library-path "${LIBRARY_PATH}" ${MAIN} "$@"
