:: PROC 12/2024 SMA monitoramento de processos com geração de arquivo de hash

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
:: Geracao do lista, tempo definido como 10 minutos, por 8h
set /a cont+=1
TASKLIST >> proc%varnome%.txt
echo proc%varnome%.txt
timeout /t 600 /nobreak > nul
echo %time%
IF %cont% NEQ %zero% (
	:: Geracao do hash
	certutil -hashfile proc%varnome%.txt %hashAlgorithm% >> proc%varnome%SHA256.txt	
) 
if %cont% lss 480 goto loop
