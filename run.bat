@echo off
chcp 65001 >nul
cls

REM ===============================================
REM   Gilded Rose Refactoring Kata - Menu
REM   DR4 TP1 - Modern CLI Interface with Colors
REM ===============================================

REM Habilita suporte a cores ANSI (Windows 10+)
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:MENU
chcp 65001 >nul
cls

REM Obtém e trunca o diretório atual
set "CURRENT_DIR=%CD%"
set "TRUNCATED_DIR=%CURRENT_DIR%"
setlocal enabledelayedexpansion
if defined CURRENT_DIR (
    if "!CURRENT_DIR:~60!" NEQ "" (
        set "TRUNCATED_DIR=...!CURRENT_DIR:~-60!"
    )
)

REM Captura o diretório antes de mostrar o menu
set "DISPLAY_DIR=%TRUNCATED_DIR%"
endlocal & set "DISPLAY_DIR=%DISPLAY_DIR%"

REM Define cores ANSI usando ESC
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

REM ═══════════════════════════════════════════════════════════════
REM   Aura Theme Color Palette - RGB ANSI Codes
REM ═══════════════════════════════════════════════════════════════
REM Purple colors
set "PURPLE=%ESC%[38;2;162;119;255m"
set "PURPLE_BOLD=%ESC%[1;38;2;162;119;255m"
set "PURPLE_DARK_SOFT=%ESC%[38;2;132;100;198m"
set "PURPLE_DARK=%ESC%[38;2;61;55;94m"
set "PURPLE_DARK_PLUS=%ESC%[38;2;41;38;60m"

REM Green colors
set "GREEN=%ESC%[38;2;97;255;202m"
set "GREEN2=%ESC%[38;2;84;197;159m"
set "GREEN_BOLD=%ESC%[1;38;2;97;255;202m"
set "GREEN_DARK_SOFT=%ESC%[38;2;42;99;80m"

REM Orange colors
set "ORANGE=%ESC%[38;2;255;202;133m"
set "ORANGE_BOLD=%ESC%[1;38;2;255;202;133m"
set "ORANGE_DARK_SOFT=%ESC%[38;2;199;160;111m"

REM Pink colors
set "PINK=%ESC%[38;2;246;148;255m"
set "PINK_BOLD=%ESC%[1;38;2;246;148;255m"
set "PINK_DARK_SOFT=%ESC%[38;2;193;122;200m"

REM Blue colors
set "BLUE=%ESC%[38;2;130;226;255m"
set "BLUE_BOLD=%ESC%[1;38;2;130;226;255m"
set "BLUE_DARK_SOFT=%ESC%[38;2;108;178;199m"

REM Red colors
set "RED=%ESC%[38;2;255;103;103m"
set "RED_BOLD=%ESC%[1;38;2;255;103;103m"
set "RED_DARK_SOFT=%ESC%[38;2;197;88;88m"

REM Neutral colors
set "WHITE=%ESC%[38;2;237;236;238m"
set "WHITE_BOLD=%ESC%[1;38;2;237;236;238m"
set "WHITE_DARK_SOFT=%ESC%[38;2;189;189;189m"
set "GRAY=%ESC%[38;2;109;109;109m"
set "GRAY_BOLD=%ESC%[1;38;2;109;109;109m"
set "BLACK=%ESC%[38;2;21;20;27m"

REM Reset
set "RESET=%ESC%[0m"

REM Reaplica UTF-8 após definir cores
chcp 65001 >nul

echo.
echo %GREEN2%╭─── Gilded Rose Kata %GRAY%· v1.0.0 ·%GREEN2% by Andre L. Becker © 2026%RESET%%GREEN2% ─────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                 %RESET%%GREEN_DARK_SOFT%│ %GREEN%Refatoracao DR4 - TP1%RESET%                 %GREEN2%│%RESET%
echo %GREEN2%│                %WHITE%Gilded Rose Refactoring Kata                     %RESET%%GREEN_DARK_SOFT%│  %WHITE%· Strategy + Factory Pattern%RESET%        %GREEN2%│%RESET%
echo %GREEN2%│                                                                 %RESET%%GREEN_DARK_SOFT%│  %WHITE%· Principios SOLID%RESET%                  %GREEN2%│%RESET%
echo %GREEN2%│ %RESET% %GREEN2%                       ╔════════════════╗                       %RESET%%GREEN_DARK_SOFT%│ ────────────────────────────────────%RESET% %GREEN2%│%RESET%
echo %GREEN2%│ %RESET% %GREEN2%                  ╔════╣  GILDED  ROSE  ╠════╗                  %RESET%%GREEN_DARK_SOFT%│ %GREEN2%Opcoes Disponiveis:%RESET%                  %GREEN2%│%RESET%
echo %GREEN2%│ %RESET% %GREEN2%                  ║    ╚════════════════╝    ║                  %RESET%%GREEN_DARK_SOFT%│                                      %GREEN2%│%RESET%
echo %GREEN2%│ %RESET% %GREEN2%                  ║    Quality  Assurance    ║                  %RESET%%GREEN_DARK_SOFT%│ %WHITE_BOLD% 1 %RESET% %GRAY%→  🧪   Testes e Cobertura        %GREEN2%│%RESET%
echo %GREEN2%│ %RESET% %GREEN2%                  ║    Refactoring  Kata    ║                  %RESET%%GREEN_DARK_SOFT%│ %WHITE_BOLD% 2 %RESET% %GRAY%→  📦   Compilar Projeto          %GREEN2%│%RESET%
echo %GREEN2%│ %RESET% %GREEN2%                  ╚═══════════════════════╝                  %RESET%%GREEN_DARK_SOFT%│ %WHITE_BOLD% 3 %RESET% %GRAY%→%PINK_DARK_SOFT%   ⌫  Limpar Build%RESET%              %GREEN2%│%RESET%
echo %GREEN2%│                                                                 %RESET%%GREEN_DARK_SOFT%│ %WHITE_BOLD% 4 %RESET% %GRAY%→  📚   Gerar JavaDoc             %GREEN2%│%RESET%
echo %GREEN2%│                                                                 %RESET%%GREEN_DARK_SOFT%│ %WHITE_BOLD% 5 %RESET% %GRAY%→  📊   Abrir Relatorios JaCoCo   %GREEN2%│%RESET%
echo %GREEN2%│                                                                 %RESET%%GREEN_DARK_SOFT%│ %WHITE_BOLD% 6 %RESET% %GRAY%→  📖   Documentacao              %GREEN2%│%RESET%
echo %GREEN2%│%GRAY%                   Refactoring Kata - DR4 TP1                    %RESET%%GREEN_DARK_SOFT%│ %WHITE_BOLD% 7 %RESET% %GRAY%→%BLUE%   ✔  Verificar Sistema%RESET%         %GREEN2%│%RESET%
echo %GREEN2%│%GRAY%                  Java 21 · Maven 3.9+ · JUnit 5                 %RESET%%GREEN_DARK_SOFT%│ %RED% 0 %RESET% %GRAY%→%RED%   ✖  Sair%RESET%                      %GREEN2%│%RESET%
echo %GREEN2%│%PURPLE_DARK_SOFT% %DISPLAY_DIR% %RESET%%GREEN_DARK_SOFT%│                                      %GREEN2%│
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK% 💬  Digite o numero da opcao desejada%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
<nul set /p "=%GREEN_BOLD% ⌨ ↳ %WHITE%" & set /p opcao= ""


REM Remove espaços da entrada
set "opcao=%opcao: =%"
%RESET%
if "%opcao%"=="1" goto EXECUTAR_TESTES
if "%opcao%"=="2" goto COMPILAR
if "%opcao%"=="3" goto LIMPAR
if "%opcao%"=="4" goto JAVADOC
if "%opcao%"=="5" goto ABRIR_RELATORIO
if "%opcao%"=="6" goto ABRIR_DOCS
if "%opcao%"=="7" goto VERIFICAR_PREREQ
if "%opcao%"=="0" goto FIM
echo.
echo   ⚠️  Opcao invalida! Tente novamente...
timeout /t 2 >nul
goto MENU

:VERIFICAR_PREREQ
chcp 65001 >nul
cls
echo.
echo %GREEN2%╭─── Verificando Pre-requisitos ─────────────────────────────────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%│   🩺  Checando ambiente de desenvolvimento...                                                           │%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.

REM Verifica Java
where java >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ❌ Java NAO encontrado!
    echo      Baixe em: https://adoptium.net/
    chcp 65001 >nul
) else (
    echo   ✅ Java encontrado:
    for /f "delims=" %%i in ('java -version 2^>^&1 ^| findstr "version"') do echo      %%i
)
echo.
chcp 65001 >nul

REM Verifica Maven
where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ❌ Maven NAO encontrado!
    echo      Baixe em: https://maven.apache.org/download.cgi
) else (
    echo   ✅ Maven encontrado:
    for /f "delims=" %%i in ('mvn -version 2^>^&1 ^| findstr "Apache Maven"') do echo      %%i
)
chcp 65001 >nul
echo.
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
pause
chcp 65001 >nul
goto MENU

:EXECUTAR_TESTES
cls
echo.
echo %GREEN2%╭─── Executando Testes com Cobertura ────────────────────────────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%│   ⌛  Executando suite JUnit 5 + Jqwik com analise de cobertura JaCoCo...                               │%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.

REM Verifica Maven
where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ❌ [ERRO] Maven nao encontrado!
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    pause
    goto MENU
)

echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK%  🧹  Limpando builds anteriores...%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
call mvn clean -q

echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK%  🧪  Executando testes com cobertura JaCoCo...%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
call mvn test

echo.
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK%  📊  Gerando relatorio de cobertura...%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
call mvn jacoco:report

if exist target\site\jacoco\index.html (
    echo.
    echo   ✅ [SUCESSO] Relatorio de cobertura gerado!
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    set /p ABRIR="  Deseja abrir o relatorio agora? (S/N): "
    if /i "%ABRIR%"=="S" (
        start target\site\jacoco\index.html
    )
)

echo.
pause
goto MENU

:COMPILAR
cls
echo.
echo %GREEN2%╭─── Compilando Projeto ─────────────────────────────────────────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%│   ⌛  Compilando codigo-fonte e gerando artefatos...                                                    │%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.

where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ❌ [ERRO] Maven nao encontrado!
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    pause
    goto MENU
)

echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK%  📦  Compilando o projeto...%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
call mvn clean compile

echo.
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK%  📦  Empacotando JAR...%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
call mvn package -DskipTests

if exist target\gilded-rose-refactoring-1.0.0.jar (
    echo.
    echo   ✅ [SUCESSO] JAR gerado em: target\gilded-rose-refactoring-1.0.0.jar
)

echo.
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
pause
goto MENU

:LIMPAR
cls
echo.
echo %GREEN2%╭─── Limpando Build ─────────────────────────────────────────────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%│   ⌛  Removendo artefatos de compilacao e build...                                                      │%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.

where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ❌ [ERRO] Maven nao encontrado!
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    pause
    goto MENU
)

echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK%  🧹  Removendo artefatos de build...%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
call mvn clean

echo.
echo   ✅ [SUCESSO] Build limpo!
echo.
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
pause
goto MENU

:JAVADOC
cls
echo.
echo %GREEN2%╭─── Gerando Documentacao JavaDoc ───────────────────────────────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%│   ✏️  Gerando documentacao tecnica do codigo...                                                         │%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.

where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   ❌ [ERRO] Maven nao encontrado!
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    pause
    goto MENU
)

echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo %BLACK%  📚  Gerando JavaDoc...%RESET%
echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
call mvn javadoc:javadoc

if exist target\site\apidocs\index.html (
    echo.
    echo   ✅ [SUCESSO] JavaDoc gerado!
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    set /p ABRIR="  Deseja abrir a documentacao? (S/N): "
    if /i "%ABRIR%"=="S" (
        start target\site\apidocs\index.html
    )
) else (
    echo.
    echo   ⚠️  [AVISO] JavaDoc nao foi gerado completamente.
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
)

echo.
pause
goto MENU

:ABRIR_RELATORIO
cls
echo.
echo %GREEN2%╭─── Abrindo Relatorio de Cobertura ─────────────────────────────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%│   🌐  Abrindo relatorio JaCoCo no navegador...                                                          │%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.

if exist target\site\jacoco\index.html (
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    echo %BLACK%  📊 Abrindo relatorio...%RESET%
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    echo.
    set /p ABRIR="  Deseja abrir o relatorio agora? (S/N): "

    rem --- compara só o primeiro caractere digitado ---
    if /i "%ABRIR:~0,1%"=="S" (
        start target\site\jacoco\index.html
        echo.
        echo ✅ [SUCESSO] Relatorio de cobertura aberto!
        echo.
        echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    )

    echo.
    pause
) else (
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    echo %BLACK%  ❌ [ERRO] Relatorio nao encontrado!%RESET%
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    echo.
    echo  %ORANGE_DARK_SOFT%⚠️  Execute testes primeiro... %WHITE%Favor escolha opcao %GREEN%1%GRAY%.%RESET%
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    pause
)

goto MENU


:ABRIR_DOCS
cls
echo.
echo %GREEN2%╭─── Abrindo Documentacao ───────────────────────────────────────────────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%│   ⌛  Abrindo documentacao completa do Trabalho Pratico 1...                                            │%RESET%
echo %GREEN2%│                                                                                                        │%RESET%
echo %GREEN2%╰────────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.

if exist doc\DOCUMENTACAO_TP1.md (
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    echo %BLACK%  📖  Abrindo doc\DOCUMENTACAO_TP1.md...%RESET%
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    start doc\DOCUMENTACAO_TP1.md
    echo.
    echo   ✅ [SUCESSO] Documentacao aberta!
    echo.
    pause
) else (
    echo   ❌ [ERRO] Arquivo doc\DOCUMENTACAO_TP1.md nao encontrado!
    echo.
    echo %PURPLE_DARK%──────────────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
    pause
)

goto MENU

:FIM
cls
echo.
echo %GREEN2%╭─── Gilded Rose Kata %GRAY%· Refatoracao DR4 ·%GREEN2% by Andre L. Becker © 2026 ────────────────────────────────────╮%RESET%
echo %GREEN2%│                                                                                                       %GREEN2%│%RESET%
echo %GREEN2%│                           %GREEN%                     ▅      %GRAY%▖%RESET% %WHITE_BOLD%Ate logo!%RESET%                                      %GREEN2%│%RESET%
echo %GREEN2%│                           %GREEN%                  ▗▛███▜▖ %GRAY%▖▘%RESET%                                                %GREEN2%│%RESET%
echo %GREEN2%│                           %GREEN%                ▜  █▄▄▄█                                                    %GREEN2%│%RESET%
echo %GREEN2%│                           %GREEN%                ▝▝▜█████▉▛▃                                                 %GREEN2%│%RESET%
echo %GREEN2%│                           %GREEN2%                    ▀██▀ %GREEN% ▀                                                 %GREEN2%│%RESET%
echo %GREEN2%│                           %GRAY%                 ▖ %BLUE_DARK_SOFT%▗▞▚▘ %GRAY% ▗▞▚▘%RESET%                                               %GREEN2%│%RESET%
echo %GREEN2%│                                                                                                       %GREEN2%│%RESET%
echo %GREEN2%│                                👋  %WHITE%Obrigado por usar o sistema !%RESET%                                       %GREEN2%│%RESET%
echo %GREEN2%╰───────────────────────────────────────────────────────────────────────────────────────────────────────╯%RESET%
echo.
timeout /t 2 >nul
exit /b 0
