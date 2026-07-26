# Instalação do U2000 no Linux

Este pacote é a distribuição Windows de 32 bits do U2000. Ele contém DLLs e
Java 8 para Windows, mas nenhuma biblioteca Linux `.so`. Por isso, o modo
compatível neste repositório usa Wine de 32 bits.

## Ubuntu/Debian

Execute em um terminal com uma conta administradora:

```console
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine wine32:i386
```

Depois clone a branch preparada e execute o diagnóstico:

```console
git clone --branch agent/linux-wine-support https://github.com/vinicius-lier/u2000_linux.git
cd u2000_linux
chmod +x u2000-linux.sh
./u2000-linux.sh --check
./u2000-linux.sh
```

O prefixo Wine é criado em `~/.local/share/u2000/wineprefix`. Para usar outro
local, defina `WINEPREFIX` antes de executar o iniciador.

## Diagnóstico

- `Wine: não instalado`: instale `wine` e `wine32:i386`.
- `Sessão gráfica: não detectada`: execute dentro da área de trabalho Linux.
- Se a primeira inicialização do Wine pedir a instalação de componentes, aceite
  e espere a configuração terminar.
- O log do cliente fica em `client/client/DebugTrace.txt`.

Não use o JRE incluído diretamente como Java Linux: `jre/bin/javaw.exe` é um
executável PE32 para Windows.
