:: LOG e HASH 11/2024 SMA um gerador simples para arquivos em batch msdos para log de conexões

set /a cont=0
:loop

:: Geracao de hashes dos arquivos de log 
set "hashAlgorithm=SHA256"

:: Geracao do hash
certutil -hashfile %varnome%.txt %hashAlgorithm% >> %varnome%SHA256.txt

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
    set second=%%c
    set varnome=%%a%%b%%c
    echo %varnome%
)

:: Geracao do netstat, tempo definido como 10 minutos, por 8h
set /a cont+=1
timeout /t 600 /nobreak > nul
netstat >> %varnome%.txt
if %cont% lss 480 goto loop
