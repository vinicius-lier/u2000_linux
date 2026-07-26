#!/usr/bin/env bash
set -uo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
WINDOWS_JAVA="$ROOT_DIR/jre/bin/javaw.exe"
WINDOWS_LAUNCHER="$ROOT_DIR/client/startup_all_global.bat"

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
    local wine_bin windows_launcher
    [[ -f "$WINDOWS_JAVA" ]] || die "Java do U2000 não encontrado: $WINDOWS_JAVA"
    [[ -f "$WINDOWS_LAUNCHER" ]] || die "iniciador não encontrado: $WINDOWS_LAUNCHER"
    [[ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]] || die "nenhuma sessão gráfica foi detectada."
    wine_bin="$(find_wine)" || die "Wine não está instalado. Consulte CONTINUAR_NO_LINUX.md."

    export WINEARCH="${WINEARCH:-win32}"
    export WINEPREFIX="${WINEPREFIX:-$HOME/.local/share/u2000/wineprefix}"
    mkdir -p -- "$WINEPREFIX"
    windows_launcher="$("$wine_bin" winepath -w "$WINDOWS_LAUNCHER")" ||
        die "não foi possível converter o caminho para o Wine."

    printf 'Iniciando U2000 com Wine (%s)...\n' "$WINEPREFIX"
    exec "$wine_bin" cmd /c "$windows_launcher" "$@"
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
