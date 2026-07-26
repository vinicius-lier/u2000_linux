#!/usr/bin/env bash
set -uo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
WINDOWS_JAVA="$ROOT_DIR/jre/bin/java.exe"
CLIENT_DIR="$ROOT_DIR/client/client"

die() {
    printf 'Erro: %s\n' "$*" >&2
    exit 1
}

find_wine() {
    command -v wine 2>/dev/null || command -v wine64 2>/dev/null
}

show_check() {
    local wine_bin
    printf 'U2000: %s\n' "$ROOT_DIR"
    printf 'Sistema: %s %s\n' "$(uname -s)" "$(uname -m)"
    if wine_bin="$(find_wine)"; then
        printf 'Wine: %s\n' "$("$wine_bin" --version 2>/dev/null || printf '%s' "$wine_bin")"
    else
        printf 'Wine: não instalado\n'
    fi
    if [[ -f "$WINDOWS_JAVA" ]]; then
        printf 'Java Windows incluído: encontrado (32 bits)\n'
    else
        printf 'Java Windows incluído: ausente\n'
    fi
    if [[ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]]; then
        printf 'Sessão gráfica: detectada\n'
    else
        printf 'Sessão gráfica: não detectada\n'
    fi
}

run_u2000() {
    local wine_bin
    [[ -f "$WINDOWS_JAVA" ]] || die "Java do U2000 não encontrado: $WINDOWS_JAVA"
    [[ -f "$CLIENT_DIR/startuploader.jar" ]] || die "startuploader.jar não encontrado."
    [[ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]] || die "nenhuma sessão gráfica foi detectada."
    wine_bin="$(find_wine)" || die "Wine não está instalado. Consulte INSTALAR_NO_LINUX.md."

    export TZ="${U2000_TZ:-UTC}"
    export WINEARCH="${WINEARCH:-win32}"
    export WINEPREFIX="${WINEPREFIX:-$HOME/.local/share/u2000/wineprefix}"
    mkdir -p -- "$WINEPREFIX"

    exec 9>"$WINEPREFIX/u2000.lock"
    if ! flock -n 9; then
        die "o U2000 já está em execução."
    fi

    cd -- "$CLIENT_DIR" || die "não foi possível acessar $CLIENT_DIR"
    printf 'Iniciando U2000 com Wine (%s)...\n' "$WINEPREFIX"
    exec "$wine_bin" "$WINDOWS_JAVA" \
        -Dprocname=client \
        -Dfile.encoding=UTF-8 \
        -classpath ./startuploader.jar \
        -Dnet.sf.ehcache.skipUpdateCheck=true \
        -Xverify:none \
        -Dparsertype=2 \
        -Xms64m \
        -Xmx256m \
        -XX:+UseSerialGC \
        -XX:MaxMetaspaceSize=256m \
        -XX:CompressedClassSpaceSize=128m \
        -XX:MaxHeapFreeRatio=40 \
        -XX:MinHeapFreeRatio=25 \
        -XX:NewRatio=12 \
        -XX:MaxNewSize=32m \
        -DloadJarExtPaths=false \
        -Dexsubsystem=cmdclient \
        -Dsun.java2d.noddraw=true \
        -Dhelpapp=run_help.bat \
        -XX:+HeapDumpOnOutOfMemoryError \
        -Dserialize=false \
        -DSingleFileChooserPath=true \
        -DskipObjFileCheck=true \
        '-Djava.library.path=../../cau/lib;./update/lib;../lib;../script/lib/core/itf' \
        -DExtesnionRigestry.debug=false \
        -Dpatchtime=true \
        -DExtesionRegistry.cacheUse=true \
        -Dscript.name=u2000-linux.sh \
        -DSpecification.Verify=true \
        com.swimap.startup.Startup \
        -debuglevel 1 \
        -showtrace false \
        -enabledebug true \
        -tracefile DebugTrace.txt \
        "$@"
}

case "${1:-}" in
    --check)
        show_check
        ;;
    -h|--help)
        printf 'Uso: %s [--check] [argumentos do U2000]\n' "${0##*/}"
        ;;
    *)
        run_u2000 "$@"
        ;;
esac
