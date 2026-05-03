#!/bin/bash

# Executa o checkupdates e armazena o resultado em uma variável
updates=$(checkupdates 2>/dev/null)
exit_status=$?

if [ $exit_status -ne 0 ]; then
    echo '{"text": "!", "tooltip": "Não foi possível localizar atualizações"}'
    exit 0
fi
# Verifica se há atualizações
if [ -z "$updates" ]; then
    # Retorna um JSON vazio ou com zero se não houver pacotes
    echo '{"text": "0", "tooltip": "Sistema atualizado"}'
else
    # Conta o número de linhas (pacotes)
    count=$(echo "$updates" | wc -l)

    # Extrai apenas a primeira coluna (nome do pacote) 
    # e formata com \n para o tooltip
    list=$(echo "$updates" | awk '{print $1 " (" $4 ")"}' | sed ':a;N;$!ba;s/\n/\\n/g')

    # Retorna o JSON formatado
    echo "{\"text\": \"$count\", \"tooltip\": \"$list\"}"
fi
