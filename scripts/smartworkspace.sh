#!/bin/bash

# O workspace de destino (ex: 1, 2, 3...) é o primeiro argumento
TARGET_WORKSPACE=$1

# Verifica se um argumento foi passado
if [ -z "$TARGET_WORKSPACE" ]; then
  # Notificação de erro (em inglês)
  notify-send -u critical "Script Error" "No target workspace provided."
  exit 1
fi

# Pega o nome do workspace ativo no momento (em formato JSON)
ACTIVE_WORKSPACE_NAME=$(hyprctl activewindow -j | jq -r '.workspace.name')
# Verifica se o nome do workspace ativo COMEÇA com "special"
if [[ "$ACTIVE_WORKSPACE_NAME" == "special"* ]]; then
  # --- BLOCO MODIFICADO ---

  # Precisamos lidar com special workspaces nomeados (ex: "special:terminal")
  if [[ "$ACTIVE_WORKSPACE_NAME" == "special:"* ]]; then
    # Extrai o nome (ex: "terminal" de "special:terminal")
    SPECIAL_NAME=$(echo "$ACTIVE_WORKSPACE_NAME" | cut -d ':' -f 2)
    # Executa os dois comandos: esconde o special E vai para o workspace
    hyprctl dispatch togglespecialworkspace $SPECIAL_NAME
    # Adiciona notificação em inglês
  else
    # É o special workspace padrão (sem nome)
    hyprctl dispatch togglespecialworkspace
    # Adiciona notificação em inglês
  fi
fi

hyprctl dispatch workspace $TARGET_WORKSPACE