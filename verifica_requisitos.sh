#!/bin/bash

# Variável para armazenar a quantidade de memória necessária (em bytes)
MEMORIA_NECESSARIA=2053736708

# Mensagem de boas-vindas
echo "Bem-vindo ao instalador do NDK!"
echo "Este script irá ajudá-lo a verificar os requisitos e instalar o NDK."
echo "Este repositório serve apenas para auxiliar na instalação do NDK."
echo "Você deve conhecer o que é o NDK e ter aceitado os termos e condições"
echo "do NDK no site oficial antes de prosseguir."
echo "Este script foi inicialmente desenvolvido para pessoas que falam Português."
echo ""

# Verifica se o Termux está instalado (verifica se o diretório raiz do Termux existe)
if [ ! -d "/data/data/com.termux/files/home" ]; then
  echo "Erro: O Termux não parece estar instalado."
  echo "Para instalar o Termux, siga as instruções no README deste repositório."
  exit 1
else
  echo "Termux instalado: OK"
fi

# Verifica a quantidade de memória disponível
MEMORIA_DISPONIVEL=$(free -b | awk 'NR==2 {print $3}')
#MEMORIA_DISPONIVEL=$(free -b | awk 'NR==2 {print $3}')

# Converte a quantidade de memória disponível para inteiro
MEMORIA_DISPONIVEL_INT=$(echo "$MEMORIA_DISPONIVEL" | sed 's/[^0-9]//g')

# Verifica se há memória suficiente
if (( "$MEMORIA_DISPONIVEL_INT" < "$MEMORIA_NECESSARIA" )); then
  echo "Aviso: Você precisa de pelo menos 1.91GB de memória RAM livre para instalar o NDK."
  echo "Memória disponível: $(echo "$MEMORIA_DISPONIVEL" | numfmt --to=iec)"
  echo "Libere espaço ou o NDK pode não funcionar corretamente."
else
  echo "Memória suficiente: OK"
fi

# Verifica se o diretório do NDK existe
if [ -d "/data/data/com.termux/files/home/android-NDK-Termux/android-ndk/android-ndk-r27c" ]; then
  echo "Aviso: Parece que você já tem o NDK instalado."
  echo "Verificando a integridade da instalação..."

  # Verifica se o arquivo ndk-build existe
  if [ ! -f "/data/data/com.termux/files/home/android-NDK-Termux/android-ndk/android-ndk-r27c/ndk-build" ]; then
    echo "Erro: Arquivo ndk-build não encontrado na instalação existente."
    echo "Recomendação: Consulte o README para reinstalar o NDK corretamente."
    exit 1
  else
    echo "Arquivo ndk-build encontrado: OK"
  fi

  # Verifica a versão do NDK (se possível)
  NDK_VERSION=$("/data/data/com.termux/files/home/android-NDK-Termux/android-ndk/android-ndk-r27c/ndk-build" --version 2>/dev/null | grep "Android NDK:")
  if [[ ! -z "$NDK_VERSION" ]]; then
    echo "$NDK_VERSION"
  else
    echo "Não foi possível verificar a versão do NDK."
  fi

  echo "NDK instalado parece íntegro."
  echo "Recomendação: Mantenha seu NDK atualizado para melhor compatibilidade."
else
  echo "NDK não detectado. Você pode prosseguir com a instalação."
fi

# Se todas as verificações passarem, exibe uma mensagem de sucesso
echo ""
echo "Verificações concluídas com sucesso!"
echo "Recomendações:"
echo "- Leia o README para obter instruções detalhadas sobre a instalação do NDK."
echo "- Mantenha seu NDK atualizado para garantir a compatibilidade com as versões mais recentes do Android."
echo "- Consulte a documentação oficial do NDK para obter informações adicionais."

exit 0