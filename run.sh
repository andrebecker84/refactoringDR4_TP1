#!/bin/bash

# ===============================================
#   Gilded Rose Refactoring Kata - Menu
#   DR4 TP1 - Modern CLI Interface with Colors
# ===============================================

# ═══════════════════════════════════════════════════════════════
#   Aura Theme Color Palette - RGB ANSI Codes
# ═══════════════════════════════════════════════════════════════
# Purple colors
PURPLE='\033[38;2;162;119;255m'
PURPLE_BOLD='\033[1;38;2;162;119;255m'
PURPLE_DARK_SOFT='\033[38;2;132;100;198m'
PURPLE_DARK='\033[38;2;61;55;94m'
PURPLE_DARK_PLUS='\033[38;2;41;38;60m'

# Green colors
GREEN='\033[38;2;97;255;202m'
GREEN2='\033[38;2;84;197;159m'
GREEN_BOLD='\033[1;38;2;97;255;202m'
GREEN_DARK_SOFT='\033[38;2;42;99;80m'

# Orange colors
ORANGE='\033[38;2;255;202;133m'
ORANGE_BOLD='\033[1;38;2;255;202;133m'
ORANGE_DARK_SOFT='\033[38;2;199;160;111m'

# Pink colors
PINK='\033[38;2;246;148;255m'
PINK_BOLD='\033[1;38;2;246;148;255m'
PINK_DARK_SOFT='\033[38;2;193;122;200m'

# Blue colors
BLUE='\033[38;2;130;226;255m'
BLUE_BOLD='\033[1;38;2;130;226;255m'
BLUE_DARK_SOFT='\033[38;2;108;178;199m'

# Red colors
RED='\033[38;2;255;103;103m'
RED_BOLD='\033[1;38;2;255;103;103m'
RED_DARK_SOFT='\033[38;2;197;88;88m'

# Neutral colors
WHITE='\033[38;2;237;236;238m'
WHITE_BOLD='\033[1;38;2;237;236;238m'
WHITE_DARK_SOFT='\033[38;2;189;189;189m'
GRAY='\033[38;2;109;109;109m'
GRAY_BOLD='\033[1;38;2;109;109;109m'
BLACK='\033[38;2;21;20;27m'

# Reset
RESET='\033[0m'

# Funcao para truncar diretorio
get_truncated_path() {
    local max_len=60
    local current_path="$PWD"
    local path_len=${#current_path}

    if [ $path_len -le $max_len ]; then
        echo "$current_path"
    else
        echo "...${current_path: -$max_len}"
    fi
}

menu() {
    clear
    local truncated_path=$(get_truncated_path)
    echo ""
    echo -e "${GREEN2}╭─── Gilded Rose Kata ${GRAY}· v1.0.0 ·${GREEN2} by Andre L. Becker © 2026${RESET}${GREEN2} ─────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                 ${RESET}${GREEN_DARK_SOFT}│ ${GREEN}Refatoracao DR4 - TP1${RESET}                 ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                ${WHITE}Gilded Rose Refactoring Kata                     ${RESET}${GREEN_DARK_SOFT}│  ${WHITE}· Strategy + Factory Pattern${RESET}        ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                                                                 ${RESET}${GREEN_DARK_SOFT}│  ${WHITE}· Principios SOLID${RESET}                  ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│ ${RESET} ${GREEN2}                       ╔════════════════╗                       ${RESET}${GREEN_DARK_SOFT}│ ────────────────────────────────────${RESET} ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│ ${RESET} ${GREEN2}                  ╔════╣  GILDED  ROSE  ╠════╗                  ${RESET}${GREEN_DARK_SOFT}│ ${GREEN2}Opcoes Disponiveis:${RESET}                  ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│ ${RESET} ${GREEN2}                  ║    ╚════════════════╝    ║                  ${RESET}${GREEN_DARK_SOFT}│                                      ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│ ${RESET} ${GREEN2}                  ║    Quality  Assurance    ║                  ${RESET}${GREEN_DARK_SOFT}│ ${WHITE_BOLD} 1 ${RESET} ${GRAY}→  🧪   Testes e Cobertura        ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│ ${RESET} ${GREEN2}                  ║    Refactoring  Kata    ║                  ${RESET}${GREEN_DARK_SOFT}│ ${WHITE_BOLD} 2 ${RESET} ${GRAY}→  📦   Compilar Projeto          ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│ ${RESET} ${GREEN2}                  ╚═══════════════════════╝                  ${RESET}${GREEN_DARK_SOFT}│ ${WHITE_BOLD} 3 ${RESET} ${GRAY}→${PINK_DARK_SOFT}   ⌫  Limpar Build${RESET}              ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                                                                 ${RESET}${GREEN_DARK_SOFT}│ ${WHITE_BOLD} 4 ${RESET} ${GRAY}→  📚   Gerar JavaDoc             ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                                                                 ${RESET}${GREEN_DARK_SOFT}│ ${WHITE_BOLD} 5 ${RESET} ${GRAY}→  📊   Abrir Relatorios JaCoCo   ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                                                                 ${RESET}${GREEN_DARK_SOFT}│ ${WHITE_BOLD} 6 ${RESET} ${GRAY}→  📖   Documentacao              ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│${GRAY}                   Refactoring Kata - DR4 TP1                    ${RESET}${GREEN_DARK_SOFT}│ ${WHITE_BOLD} 7 ${RESET} ${GRAY}→${BLUE}   ✔  Verificar Sistema${RESET}         ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│${GRAY}                  Java 21 · Maven 3.9+ · JUnit 5                 ${RESET}${GREEN_DARK_SOFT}│ ${RED} 0 ${RESET} ${GRAY}→${RED}   ✖  Sair${RESET}                      ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│${PURPLE_DARK_SOFT} ${truncated_path} ${RESET}${GREEN_DARK_SOFT}│                                      ${GREEN2}│"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK} 💬  Digite o numero da opcao desejada${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -ne "${GREEN_BOLD} ⌨ ↳ ${WHITE}" && read -r opcao
    echo -e "${RESET}"

    case $opcao in
        1) executar_testes ;;
        2) compilar ;;
        3) limpar ;;
        4) javadoc ;;
        5) abrir_relatorio ;;
        6) abrir_docs ;;
        7) verificar_prereq ;;
        0) sair ;;
        *)
            echo ""
            echo -e "  ⚠️  Opcao invalida! Tente novamente..."
            sleep 2
            menu
            ;;
    esac
}

verificar_prereq() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Verificando Pre-requisitos ─────────────────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}│   🩺  Checando ambiente de desenvolvimento...                                                           │${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""

    if command -v java &> /dev/null; then
        echo -e "  ✅ Java encontrado:"
        java -version 2>&1 | head -1 | sed "s/^/     /"
    else
        echo -e "  ❌ Java NAO encontrado!"
        echo -e "     Baixe em: https://adoptium.net/"
    fi
    echo ""

    if command -v mvn &> /dev/null; then
        echo -e "  ✅ Maven encontrado:"
        mvn -version 2>&1 | head -1 | sed "s/^/     /"
    else
        echo -e "  ❌ Maven NAO encontrado!"
        echo -e "     Baixe em: https://maven.apache.org/download.cgi"
    fi
    echo ""
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    read -r -p "Pressione ENTER para voltar..."
    menu
}

executar_testes() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Executando Testes com Cobertura ────────────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}│   ⌛  Executando suite JUnit 5 + Jqwik com analise de cobertura JaCoCo...                               │${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""

    if ! command -v mvn &> /dev/null; then
        echo -e "  ❌ [ERRO] Maven nao encontrado!"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "Pressione ENTER para voltar..."
        menu
        return
    fi

    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK}  🧹  Limpando builds anteriores...${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo ""
    mvn clean -q

    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK}  🧪  Executando testes com cobertura JaCoCo...${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo ""
    mvn test

    echo ""
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK}  📊  Gerando relatorio de cobertura...${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo ""
    mvn jacoco:report

    if [ -f "target/site/jacoco/index.html" ]; then
        echo ""
        echo -e "  ✅ [SUCESSO] Relatorio de cobertura gerado!"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "  Deseja abrir o relatorio agora? (S/N): " abrir
        if [[ $abrir =~ ^[Ss]$ ]]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open target/site/jacoco/index.html
            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open target/site/jacoco/index.html 2>/dev/null || \
                firefox target/site/jacoco/index.html 2>/dev/null || \
                google-chrome target/site/jacoco/index.html 2>/dev/null
            fi
        fi
    fi

    echo ""
    read -r -p "Pressione ENTER para voltar..."
    menu
}

compilar() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Compilando Projeto ─────────────────────────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}│   ⌛  Compilando codigo-fonte e gerando artefatos...                                                    │${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""

    if ! command -v mvn &> /dev/null; then
        echo -e "  ❌ [ERRO] Maven nao encontrado!"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "Pressione ENTER para voltar..."
        menu
        return
    fi

    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK}  📦  Compilando o projeto...${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo ""
    mvn clean compile

    echo ""
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK}  📦  Empacotando JAR...${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo ""
    mvn package -DskipTests

    if [ -f "target/gilded-rose-refactoring-1.0.0.jar" ]; then
        echo ""
        echo -e "  ✅ [SUCESSO] JAR gerado em: target/gilded-rose-refactoring-1.0.0.jar"
    fi

    echo ""
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    read -r -p "Pressione ENTER para voltar..."
    menu
}

limpar() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Limpando Build ─────────────────────────────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}│   ⌛  Removendo artefatos de compilacao e build...                                                      │${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""

    if ! command -v mvn &> /dev/null; then
        echo -e "  ❌ [ERRO] Maven nao encontrado!"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "Pressione ENTER para voltar..."
        menu
        return
    fi

    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK}  🧹  Removendo artefatos de build...${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo ""
    mvn clean

    echo ""
    echo -e "  ✅ [SUCESSO] Build limpo!"
    echo ""
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    read -r -p "Pressione ENTER para voltar..."
    menu
}

javadoc() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Gerando Documentacao JavaDoc ───────────────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}│   ✏️  Gerando documentacao tecnica do codigo...                                                         │${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""

    if ! command -v mvn &> /dev/null; then
        echo -e "  ❌ [ERRO] Maven nao encontrado!"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "Pressione ENTER para voltar..."
        menu
        return
    fi

    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${BLACK}  📚  Gerando JavaDoc...${RESET}"
    echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    echo ""
    mvn javadoc:javadoc

    if [ -f "target/site/apidocs/index.html" ]; then
        echo ""
        echo -e "  ✅ [SUCESSO] JavaDoc gerado!"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "  Deseja abrir a documentacao? (S/N): " abrir
        if [[ $abrir =~ ^[Ss]$ ]]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open target/site/apidocs/index.html
            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open target/site/apidocs/index.html 2>/dev/null
            fi
        fi
    else
        echo ""
        echo -e "  ⚠️  [AVISO] JavaDoc nao foi gerado completamente."
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
    fi

    echo ""
    read -r -p "Pressione ENTER para voltar..."
    menu
}

abrir_relatorio() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Abrindo Relatorio de Cobertura ─────────────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}│   🌐  Abrindo relatorio JaCoCo no navegador...                                                          │${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""

    if [ -f "target/site/jacoco/index.html" ]; then
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        echo -e "${BLACK}  📊 Abrindo relatorio...${RESET}"
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        echo ""
        read -r -p "  Deseja abrir o relatorio agora? (S/N): " abrir

        if [[ ${abrir:0:1} =~ ^[Ss]$ ]]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                open target/site/jacoco/index.html
            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open target/site/jacoco/index.html 2>/dev/null
            fi
            echo ""
            echo -e "✅ [SUCESSO] Relatorio de cobertura aberto!"
            echo ""
            echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        fi

        echo ""
        read -r -p "Pressione ENTER para voltar..."
    else
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        echo -e "${BLACK}  ❌ [ERRO] Relatorio nao encontrado!${RESET}"
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        echo ""
        echo -e " ${ORANGE_DARK_SOFT}⚠️  Execute testes primeiro... ${WHITE}Favor escolha opcao ${GREEN}1${GRAY}.${RESET}"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "Pressione ENTER para voltar..."
    fi

    menu
}

abrir_docs() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Abrindo Documentacao ───────────────────────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}│   ⌛  Abrindo documentacao completa do Trabalho Pratico 1...                                            │${RESET}"
    echo -e "${GREEN2}│                                                                                                        │${RESET}"
    echo -e "${GREEN2}╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""

    if [ -f "doc/DOCUMENTACAO_TP1.md" ]; then
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        echo -e "${BLACK}  📖  Abrindo doc/DOCUMENTACAO_TP1.md...${RESET}"
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open doc/DOCUMENTACAO_TP1.md
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open doc/DOCUMENTACAO_TP1.md 2>/dev/null
        fi
        echo ""
        echo -e "  ✅ [SUCESSO] Documentacao aberta!"
        echo ""
        read -r -p "Pressione ENTER para voltar..."
    else
        echo -e "  ❌ [ERRO] Arquivo doc/DOCUMENTACAO_TP1.md nao encontrado!"
        echo ""
        echo -e "${PURPLE_DARK}──────────────────────────────────────────────────────────────────────────────────────────────────────────${RESET}"
        read -r -p "Pressione ENTER para voltar..."
    fi

    menu
}

sair() {
    clear
    echo ""
    echo -e "${GREEN2}╭─── Gilded Rose Kata ${GRAY}· Refatoracao DR4 ·${GREEN2} by Andre L. Becker © 2026 ────────────────────────────────────╮${RESET}"
    echo -e "${GREEN2}│                                                                                                       ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                           ${GREEN}                     ▅      ${GRAY}▖${RESET} ${WHITE_BOLD}Ate logo!${RESET}                                      ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                           ${GREEN}                  ▗▛███▜▖ ${GRAY}▖▘${RESET}                                                ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                           ${GREEN}                ▜  █▄▄▄█                                                    ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                           ${GREEN}                ▝▝▜█████▉▛▃                                                 ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                           ${GREEN2}                    ▀██▀ ${GREEN} ▀                                                 ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                           ${GRAY}                 ▖ ${BLUE_DARK_SOFT}▗▞▚▘ ${GRAY} ▗▞▚▘${RESET}                                               ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                                                                                                       ${GREEN2}│${RESET}"
    echo -e "${GREEN2}│                                👋  ${WHITE}Obrigado por usar o sistema !${RESET}                                       ${GREEN2}│${RESET}"
    echo -e "${GREEN2}╰───────────────────────────────────────────────────────────────────────────────────────────────────────╯${RESET}"
    echo ""
    sleep 2
    exit 0
}

# Inicio do script
menu
