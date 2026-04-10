#!/usr/bin/env python3
import sys
import colorsys

def hex_to_hsv_255(hex_color):
    """
    Converte uma cor em formato hexadecimal para HSV na base 255.
    """
    hex_color = hex_color.lstrip('#')

    if len(hex_color) != 6:
        raise ValueError("O código hexadecimal deve ter 6 caracteres (ex: 00FF00 ou #00FF00)")

    r_int = int(hex_color[0:2], 16)
    g_int = int(hex_color[2:4], 16)
    b_int = int(hex_color[4:6], 16)

    r_norm = r_int / 255.0
    g_norm = g_int / 255.0
    b_norm = b_int / 255.0

    h, s, v = colorsys.rgb_to_hsv(r_norm, g_norm, b_norm)

    return round(h * 255), round(s * 255), round(v * 255)

if __name__ == "__main__":
    # Verifica se o usuário passou um argumento além do nome do próprio script
    if len(sys.argv) < 2:
        print("Uso correto: ./convertColor.py <cor_hexadecimal>")
        print("Exemplo: ./convertColor.py #124ab3")
        sys.exit(1)

    # Pega o primeiro argumento passado no terminal
    hex_input = sys.argv[1]

    try:
        h, s, v = hex_to_hsv_255(hex_input)
        print(f"HSV(255): {h}, {s}, {v}")
    except ValueError as e:
        print(f"Erro: {e}")
        sys.exit(1)
