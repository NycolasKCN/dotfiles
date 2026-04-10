#!/usr/bin/env bash
 
set -euo pipefail
 
# ---------------------------------------------------------------------------
# crop_image.sh
# Uso: ./crop_image.sh -i <path> -w <width> -h <height> -f <formato>
# ---------------------------------------------------------------------------
 
usage() {
  echo "Uso: $0 -i <input> -w <width> -h <height> -f <formato>"
  echo ""
  echo "  -i  Caminho da imagem de entrada"
  echo "  -w  Largura desejada (px)"
  echo "  -h  Altura desejada (px)"
  echo "  -f  Formato de saída (ex: jpg, png, webp)"
  echo ""
  echo "Exemplo: $0 -i foto.png -w 800 -h 600 -f webp"
  exit 1
}
 
INPUT=""
WIDTH=""
HEIGHT=""
FORMAT=""
 
while getopts "i:w:h:f:" opt; do
  case $opt in
    i) INPUT="$OPTARG" ;;
    w) WIDTH="$OPTARG" ;;
    h) HEIGHT="$OPTARG" ;;
    f) FORMAT="$OPTARG" ;;
    *) usage ;;
  esac
done
 
# --- Validações ---
[ -z "$INPUT" ]  && echo "Erro: informe o path de entrada (-i)."  && usage
[ -z "$WIDTH" ]  && echo "Erro: informe a largura (-w)."          && usage
[ -z "$HEIGHT" ] && echo "Erro: informe a altura (-h)."           && usage
[ -z "$FORMAT" ] && echo "Erro: informe o formato (-f)."          && usage
 
[ -f "$INPUT" ] || { echo "Erro: arquivo '$INPUT' não encontrado."; exit 1; }
 
[[ "$WIDTH"  =~ ^[1-9][0-9]*$ ]] || { echo "Erro: largura deve ser um inteiro positivo."; exit 1; }
[[ "$HEIGHT" =~ ^[1-9][0-9]*$ ]] || { echo "Erro: altura deve ser um inteiro positivo.";  exit 1; }
 
# --- Saída ---
BASENAME=$(basename "$INPUT")
NAME="${BASENAME%.*}"
OUTPUT="${NAME}_${WIDTH}x${HEIGHT}.${FORMAT}"
 
# --- Filtro ffmpeg ---
# scale: usa iw/ih (dimensões da entrada) para evitar circular reference.
#   - Se aspect ratio entrada > target → escala pela altura
#   - Caso contrário → escala pela largura
# Garante que a imagem sempre cubra o target inteiro antes do crop.
# crop: recorta do centro (padrão do ffmpeg quando x/y são omitidos).
FILTER="scale='if(gt(iw/ih,${WIDTH}/${HEIGHT}),trunc(${HEIGHT}*iw/ih/2)*2,${WIDTH})':'if(gt(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},trunc(${WIDTH}*ih/iw/2)*2)',crop=${WIDTH}:${HEIGHT}"
 
echo "Convertendo '$INPUT' → '$OUTPUT' (${WIDTH}x${HEIGHT}, formato: ${FORMAT})"
 
ffmpeg -hide_banner -loglevel warning \
  -i "$INPUT" \
  -vf "$FILTER" \
  -frames:v 1 \
  "$OUTPUT"
 
echo "Concluído: $OUTPUT"
 
