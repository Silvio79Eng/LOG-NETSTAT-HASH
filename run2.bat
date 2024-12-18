:: LOG e HASH 11/2024 SMA um gerador simples para arquivos em batch msdos para log de conexões

set /a cont=0
set /a zero=0
:loop

for /f "tokens=1-3 delims=/" %%a in ("%DATE%") do (
   set dia=%%a
   set mes=%%b
   set ano=%%c
   set data=%%a%%b%%c
   echo %data%
)

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
    set second=%%c
    set varnome=%%a%%b%%c%data%
    echo %varnome%
)

:: Geracao do netstat, tempo definido como 10 minutos, por 8h
set /a cont+=1
netstat >> %varnome%.txt
timeout /t 600 /nobreak > nul
echo %time%
IF %cont% NEQ %zero% (
	:: Geracao do hash netstat
	certutil -hashfile %varnome%.txt %hashAlgorithm% >> %varnome%SHA256.txt	
)
echo "hash gerado"
if %cont% lss 480 goto loop