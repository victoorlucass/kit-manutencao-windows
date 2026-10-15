@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Kit de Manutencao do Windows - v2
color 0B

set "LOG=%USERPROFILE%\Desktop\Relatorio_Manutencao_Windows.txt"

:: Solicita elevacao para tarefas administrativas.
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo Solicitando permissao de administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo ==========================================================
echo          KIT DE MANUTENCAO DO WINDOWS - v1
echo ==========================================================
echo.
echo  LIMPEZA E MANUTENCAO
echo  [1] Limpar arquivos temporarios do usuario e do Windows
echo  [2] Limpar downloads do Windows Update
echo  [3] Otimizar unidades (Windows escolhe a operacao)
echo  [4] Desativar hibernacao (libera espaco, desativa o recurso)
echo  [5] Abrir Limpeza de Disco do Windows
echo  [6] Verificar/reparar arquivos do sistema (DISM + SFC)
echo  [7] Abrir Configuracoes de Armazenamento
echo.
echo  POS-FORMATACAO E FERRAMENTAS
echo  [8] Rotina segura pos-formatacao
echo  [9] Instalar programas comuns com winget
echo  [10] Gerar relatorio do computador
echo  [11] Abrir ferramentas uteis do Windows
echo  [12] Limpar Prefetch (opcional; geralmente desnecessario)
echo  [0] Sair
echo.
set "opcao="
set /p "opcao=Escolha uma opcao: "

if "%opcao%"=="1" goto TEMP
if "%opcao%"=="2" goto UPDATE
if "%opcao%"=="3" goto OTIMIZAR
if "%opcao%"=="4" goto HIBERNACAO
if "%opcao%"=="5" goto DISKCLEAN
if "%opcao%"=="6" goto REPARAR
if "%opcao%"=="7" goto ARMAZENAMENTO
if "%opcao%"=="8" goto POSFORMAT
if "%opcao%"=="9" goto WINGET
if "%opcao%"=="10" goto RELATORIO
if "%opcao%"=="11" goto FERRAMENTAS
if "%opcao%"=="12" goto PREFETCH
if "%opcao%"=="0" goto FIM
echo Opcao invalida.
timeout /t 2 >nul
goto MENU

:TEMP
cls
echo Limpando arquivos temporarios. Arquivos em uso serao ignorados...
call :LIMPAR_PASTA "%TEMP%"
call :LIMPAR_PASTA "%SystemRoot%\Temp"
echo.
echo Concluido. Alguns arquivos podem permanecer por estarem em uso.
pause
goto MENU

:LIMPAR_PASTA
if not exist "%~1" exit /b
echo Limpando: %~1
del /f /s /q "%~1\*" >nul 2>&1
for /d %%D in ("%~1\*") do (
    if exist "%%~fD\" rd /s /q "%%~fD" >nul 2>&1
)
exit /b

:UPDATE
cls
echo ATENCAO:
echo - Nao execute durante uma atualizacao ou instalacao do Windows.
echo - O Windows pode baixar novamente alguns arquivos depois.
echo.
choice /c SN /n /m "Limpar arquivos em SoftwareDistribution\Download? [S/N] "
if errorlevel 2 goto MENU
echo.
net stop bits >nul 2>&1
net stop wuauserv >nul 2>&1
if exist "%SystemRoot%\SoftwareDistribution\Download\" (
    del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
    for /d %%D in ("%SystemRoot%\SoftwareDistribution\Download\*") do (
        if exist "%%~fD\" rd /s /q "%%~fD" >nul 2>&1
    )
)
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo Limpeza solicitada. Arquivos bloqueados podem permanecer.
pause
goto MENU

:OTIMIZAR
cls
echo O Windows selecionara a operacao apropriada para cada unidade fixa.
echo Em SSDs, o Windows normalmente executa retrim; em HDDs, desfragmenta quando apropriado.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$drives = Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Where-Object { $_.DeviceID -match '^[A-Z]:' }; foreach ($d in $drives) { $letter = $d.DeviceID.Substring(0,1); Write-Host ('`nOtimizando unidade ' + $letter + ':'); Optimize-Volume -DriveLetter $letter -Verbose }"
echo.
echo Operacao finalizada. Leia mensagens e eventuais erros acima.
pause
goto MENU

:HIBERNACAO
cls
echo Desativar a hibernacao remove hiberfil.sys e pode liberar espaco.
echo Tambem desativa a hibernacao e pode desativar a Inicializacao Rapida.
echo.
choice /c SN /n /m "Confirmar desativacao da hibernacao? [S/N] "
if errorlevel 2 goto MENU
powercfg /hibernate off
echo.
echo Comando executado.
pause
goto MENU

:DISKCLEAN
cleanmgr /d C:
goto MENU

:REPARAR
cls
echo DISM e SFC verificam e tentam reparar componentes e arquivos do Windows.
echo O processo pode demorar; DISM pode precisar de internet.
echo.
choice /c SN /n /m "Continuar? [S/N] "
if errorlevel 2 goto MENU
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
echo.
echo Diagnostico concluido. Leia os resultados acima.
pause
goto MENU

:ARMAZENAMENTO
start "" ms-settings:storagesense
goto MENU

:POSFORMAT
cls
echo ROTINA POS-FORMATACAO SEGURA
echo Esta rotina limpa temporarios e otimiza unidades.
echo Ela NAO desativa servicos, NAO altera o Registro e NAO limpa o Windows Update.
echo.
choice /c SN /n /m "Executar a rotina? [S/N] "
if errorlevel 2 goto MENU
call :LIMPAR_PASTA "%TEMP%"
call :LIMPAR_PASTA "%SystemRoot%\Temp"
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$drives = Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Where-Object { $_.DeviceID -match '^[A-Z]:' }; foreach ($d in $drives) { $letter = $d.DeviceID.Substring(0,1); Write-Host ('`nOtimizando unidade ' + $letter + ':'); Optimize-Volume -DriveLetter $letter -Verbose }"
echo.
echo Rotina concluida. Recomenda-se executar o Windows Update e reiniciar quando solicitado.
pause
goto MENU

:WINGET
cls
echo INSTALACAO DE PROGRAMAS COM WINGET
echo Requer o Gerenciador de Pacotes do Windows (winget) instalado.
echo Os instaladores e termos de cada aplicativo podem ser exibidos.
echo.
where winget >nul 2>&1
if errorlevel 1 (
    echo winget nao foi encontrado. Atualize/instale "Instalador de Aplicativo"
    echo pela Microsoft Store e tente novamente.
    pause
    goto MENU
)
echo [1] Google Chrome
echo [2] Mozilla Firefox
echo [3] 7-Zip
echo [4] VLC
echo [5] Visual Studio Code
echo [6] Git
echo [7] Python 3
echo [8] Tudo acima
echo [0] Voltar
echo.
set "apps="
set /p "apps=Digite uma opcao (ex.: 3) ou 8 para todos: "
if "%apps%"=="0" goto MENU
if "%apps%"=="1" winget install --id Google.Chrome -e
if "%apps%"=="2" winget install --id Mozilla.Firefox -e
if "%apps%"=="3" winget install --id 7zip.7zip -e
if "%apps%"=="4" winget install --id VideoLAN.VLC -e
if "%apps%"=="5" winget install --id Microsoft.VisualStudioCode -e
if "%apps%"=="6" winget install --id Git.Git -e
if "%apps%"=="7" winget install --id Python.Python.3 -e
if "%apps%"=="8" (
    winget install --id Google.Chrome -e
    winget install --id Mozilla.Firefox -e
    winget install --id 7zip.7zip -e
    winget install --id VideoLAN.VLC -e
    winget install --id Microsoft.VisualStudioCode -e
    winget install --id Git.Git -e
    winget install --id Python.Python.3 -e
)
echo.
echo Se algum programa falhou, consulte a mensagem do winget.
pause
goto MENU

:RELATORIO
cls
echo Gerando relatorio em:
echo %LOG%
echo.
(
    echo ==========================================================
    echo RELATORIO DE MANUTENCAO DO WINDOWS
    echo Data: %DATE% %TIME%
    echo Computador: %COMPUTERNAME%
    echo Usuario: %USERNAME%
    echo ==========================================================
    echo.
    echo --- Windows ---
    systeminfo
    echo.
    echo --- Discos logicos e espaco livre ---
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID,VolumeName,@{N='TamanhoGB';E={[math]::Round($_.Size/1GB,2)}},@{N='LivreGB';E={[math]::Round($_.FreeSpace/1GB,2)}} | Format-Table -AutoSize"
    echo.
    echo --- Memoria e processador ---
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_ComputerSystem | Select-Object Manufacturer,Model,@{N='RAM_GB';E={[math]::Round($_.TotalPhysicalMemory/1GB,2)}} | Format-List; Get-CimInstance Win32_Processor | Select-Object Name,NumberOfCores,NumberOfLogicalProcessors | Format-List"
    echo.
    echo --- Tipo de unidade fisica (quando reportado pelo Windows) ---
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-PhysicalDisk | Select-Object FriendlyName,MediaType,HealthStatus,OperationalStatus,Size | Format-Table -AutoSize"
) > "%LOG%" 2>&1
echo Relatorio criado na Area de Trabalho.
start "" notepad "%LOG%"
pause
goto MENU

:FERRAMENTAS
cls
echo [1] Gerenciador de Tarefas
echo [2] Gerenciador de Dispositivos
echo [3] Monitor de Recursos
echo [4] Monitor de Confiabilidade
echo [5] Informacoes do Sistema
echo [6] Limpeza de Disco
echo [0] Voltar
echo.
set "ferr="
set /p "ferr=Escolha: "
if "%ferr%"=="1" start "" taskmgr
if "%ferr%"=="2" start "" devmgmt.msc
if "%ferr%"=="3" start "" resmon
if "%ferr%"=="4" start "" perfmon /rel
if "%ferr%"=="5" start "" msinfo32
if "%ferr%"=="6" start "" cleanmgr /d C:
if "%ferr%"=="0" goto MENU
goto FERRAMENTAS

:PREFETCH
cls
echo AVISO: limpar Prefetch geralmente nao melhora o desempenho.
echo O Windows gerencia esses arquivos; a primeira abertura de aplicativos pode ficar mais lenta.
echo.
choice /c SN /n /m "Deseja realmente limpar o conteudo de Prefetch? [S/N] "
if errorlevel 2 goto MENU
del /f /s /q "%SystemRoot%\Prefetch\*" >nul 2>&1
echo Comando executado. Arquivos bloqueados ou protegidos podem permanecer.
pause
goto MENU

:FIM
echo Ate mais!
timeout /t 2 >nul
endlocal
exit /b
