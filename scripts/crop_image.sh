#!/usr/bin/env bash

set -euo pipefail

# ---------------------------------------------------------------------------
# crop_image.sh
# Uso: ./crop_image.sh -i <path> [-w <width>] [-h <height>] [-f <formato>]
# ---------------------------------------------------------------------------

usage() {
  echo "Uso: $0 -i <input> [-w <width>] [-h <height>] [-f <formato>]"
  echo ""
  echo "  -i  Caminho da imagem de entrada"
  echo "  -w  Largura desejada (px)  [opcional: mantém a original]"
  echo "  -h  Altura desejada (px)   [opcional: mantém a original]"
  echo "  -f  Formato de saída (ex: jpg, png, webp)  [opcional: mantém o original]"
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
[ -z "$INPUT" ] && echo "Erro: informe o path de entrada (-i)." && usage

[ -f "$INPUT" ] || { echo "Erro: arquivo '$INPUT' não encontrado."; exit 1; }

[[ -z "$WIDTH"  || "$WIDTH"  =~ ^[1-9][0-9]*$ ]] || { echo "Erro: largura deve ser um inteiro positivo.";  exit 1; }
[[ -z "$HEIGHT" || "$HEIGHT" =~ ^[1-9][0-9]*$ ]] || { echo "Erro: altura deve ser um inteiro positivo.";   exit 1; }

# --- Dimensões e formato originais (usados quando omitidos) ---
ORIG_W=$(ffprobe -v error -select_streams v:0 -show_entries stream=width  -of csv=p=0 "$INPUT")
ORIG_H=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$INPUT")
ORIG_EXT="${INPUT##*.}"

WIDTH="${WIDTH:-$ORIG_W}"
HEIGHT="${HEIGHT:-$ORIG_H}"
FORMAT="${FORMAT:-$ORIG_EXT}"

# --- Saída ---
BASENAME=$(basename "$INPUT")
NAME="${BASENAME%.*}"
OUTPUT="${NAME}_${WIDTH}x${HEIGHT}.${FORMAT}"

# --- Filtro ffmpeg ---
FILTER="scale='if(gt(iw/ih,${WIDTH}/${HEIGHT}),trunc(${HEIGHT}*iw/ih/2)*2,${WIDTH})':'if(gt(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},trunc(${WIDTH}*ih/iw/2)*2)',crop=${WIDTH}:${HEIGHT}"

echo "Convertendo '$INPUT' → '$OUTPUT' (${WIDTH}x${HEIGHT}, formato: ${FORMAT})"

ffmpeg -hide_banner -loglevel warning \
  -i "$INPUT" \
  -vf "$FILTER" \
  -frames:v 1 \
  "$OUTPUT"

echo "Concluído: $OUTPUT"
