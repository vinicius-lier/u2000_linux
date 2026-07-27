# Continuação no Linux — U2000

## Estado atual

- Este diretório contém o cliente Huawei U2000 para Windows.
- Nenhum arquivo original do U2000 foi alterado.
- O pacote possui um iniciador Linux em `client/startup_all_global.sh`.
- O JRE incluído em `jre/` é Java 8u161 para Windows (32 bits) e não funciona
  nativamente no Linux.
- O pacote contém DLLs e executáveis Windows, mas não contém as bibliotecas
  Linux `.so`. Portanto, a interface Java pode iniciar, mas algumas funções
  podem não funcionar.
- Este diretório ainda não é um repositório Git (não existe `.git`).

## Localização no Windows

`C:\Users\vinic\OneDrive\Documentos\Games\U2000`

Depois de iniciar o Linux, abra o gerenciador de arquivos e monte a partição
Windows de aproximadamente 512 GB. Navegue até:

`Users/vinic/OneDrive/Documentos/Games/U2000`

Copie a pasta `U2000` inteira para a sua pasta pessoal no Linux antes de
trabalhar nela. Não execute diretamente na partição Windows se ela estiver
hibernada ou marcada como não encerrada corretamente.

Exemplo, ajustando o caminho da partição montada:

```bash
mkdir -p ~/Games
cp -a "/CAMINHO/DA/PARTICAO/Users/vinic/OneDrive/Documentos/Games/U2000" ~/Games/
code ~/Games/U2000/U2000.code-workspace
```

## Preparação para teste nativo

Instale um Java 8 compatível com sua distribuição. Depois:

```bash
cd ~/Games/U2000
export IMAP_JAVA_HOME=/caminho/do/java8
export DISPLAY="${DISPLAY:-:0}"
chmod +x client/startup_all_global.sh
./client/startup_all_global.sh
```

O script grava os detalhes de execução em
`client/client/DebugTrace.txt`, embora sua saída normal seja descartada.

## Próxima etapa recomendada

1. Copiar o diretório para o SSD Linux.
2. Abrir `U2000.code-workspace` no VS Code.
3. Instalar Java 8 no Linux.
4. Testar o iniciador e analisar `DebugTrace.txt`.
5. Se houver erro de biblioteca nativa, procurar a distribuição oficial Linux
   do mesmo release do U2000 ou usar esta distribuição com Wine.

