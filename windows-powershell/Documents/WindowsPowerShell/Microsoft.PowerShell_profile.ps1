


Set-PSReadLineKeyHandler -Chord Ctrl+Shift+u -Function Undo
Set-PSReadLineKeyHandler -Chord Ctrl+z -Function Undo
Set-PSReadLineKeyHandler -Chord Ctrl+g -Function ForwardWord
Set-PSReadLineKeyHandler -Chord Ctrl+f -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+b -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord Ctrl+n -Function DeleteWord
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function KillLine

Set-PSReadLineKeyHandler -Chord Ctrl+d -ScriptBlock {
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ([string]::IsNullOrEmpty($line)) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("exit")
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::DeleteChar()
    }
}


Set-Location $HOME

function prompt {
   "$(Get-Location | ForEach-Object { $_.Path.Replace('\','/') })> "
}


Remove-Item Alias:ls -ErrorAction SilentlyContinue

function ls {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    $flags = ""
    $paths = @()

    foreach ($arg in $Args) {
        if ($arg -match '^-[A-Za-z]+$') {
            $flags += $arg.Substring(1)
        } else {
            $paths += $arg
        }
    }

    if ($paths.Count -eq 0) {
        $paths = @(".")
    }

    $items = Get-ChildItem @paths

    $reverse = $flags.Contains("r")
    $long    = $flags.Contains("l")

    if ($flags.Contains("S")) {
        $items = $items | Sort-Object Length -Descending:(!$reverse)
    }
    elseif ($flags.Contains("t")) {
        $items = $items | Sort-Object LastWriteTime -Descending:(!$reverse)
    }
    else {
        $items = $items | Sort-Object Name -Descending:$reverse
    }

    if ($long) {
        $items | Format-Table Mode, LastWriteTime, Length, Name -AutoSize
    } else {
        $items
    }
}

Set-Alias less more

function Invoke-Starship-TransientFunction {
  &starship module character
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt


Invoke-Expression (&starship init powershell)
