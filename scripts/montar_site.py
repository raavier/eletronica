#!/usr/bin/env python3
"""Monta build/docs/ a partir de trilha/ e pocket-ai/ para o MkDocs.

Os .md originais continuam funcionando no GitHub e no editor; este script
só ajusta o que muda no site: links para fora de trilha/, <details> com
Markdown dentro e as caixas da lista de compras.
"""
import re
import shutil
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SAIDA = RAIZ / "build" / "docs"


def ajustar(texto: str) -> str:
    texto = texto.replace("../pocket-ai/README.md", "pocket-ai.md")
    # ha-voice-hub não vai para o site: vira texto simples.
    texto = re.sub(r"\[(`?ha-voice-hub/?`?)\]\(\.\./ha-voice-hub/?\)", r"\1", texto)
    texto = texto.replace("<details>", '<details markdown="1">')
    # Coluna ☐ da lista de compras vira caixa clicável.
    texto = re.sub(r"^\| ☐ \|", '| <input type="checkbox" class="caixa"> |', texto, flags=re.M)
    texto = texto.replace("| ☐ | Qtd |", "| ✓ | Qtd |")
    return texto


def main() -> None:
    if SAIDA.exists():
        shutil.rmtree(SAIDA)
    SAIDA.mkdir(parents=True)

    for md in (RAIZ / "trilha").glob("*.md"):
        destino = "index.md" if md.name == "README.md" else md.name
        (SAIDA / destino).write_text(ajustar(md.read_text()))

    shutil.copy(RAIZ / "trilha" / "compras.csv", SAIDA / "compras.csv")
    (SAIDA / "pocket-ai.md").write_text(ajustar((RAIZ / "pocket-ai" / "README.md").read_text()))
    shutil.copytree(RAIZ / "site-extra", SAIDA, dirs_exist_ok=True)


if __name__ == "__main__":
    main()
