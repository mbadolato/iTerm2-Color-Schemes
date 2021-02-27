#requires -version 5
if (-not (Test-Path ../vscode)) {New-Item -ItemType Directory ../vscode}
Get-Item ../WindowsTerminal/*.json | Foreach-Object {
    write-verbose "Generating vscode theme for $($PSItem.name)"
    $theme = Get-Content -raw $PSItem | ConvertFrom-JSON
    @"
{
    "workbench.colorCustomizations": {
        "terminal.foreground": "$($theme.foreground)",
        "terminal.background": "$($theme.background)",
        "terminal.ansiBlack": "$($theme.black)",
        "terminal.ansiBlue": "$($theme.blue)",
        "terminal.ansiCyan": "$($theme.cyan)",
        "terminal.ansiGreen": "$($theme.green)",
        "terminal.ansiMagenta": "$($theme.purple)",
        "terminal.ansiRed": "$($theme.red)",
        "terminal.ansiWhite": "$($theme.white)",
        "terminal.ansiYellow": "$($theme.yellow)",
        "terminal.ansiBrightBlack": "$($theme.brightBlack)",
        "terminal.ansiBrightBlue": "$($theme.brightBlue)",
        "terminal.ansiBrightCyan": "$($theme.brightCyan)",
        "terminal.ansiBrightGreen": "$($theme.brightGreen)",
        "terminal.ansiBrightMagenta": "$($theme.brightPurple)",
        "terminal.ansiBrightRed": "$($theme.brightRed)",
        "terminal.ansiBrightWhite": "$($theme.brightWhite)",
        "terminal.ansiBrightYellow": "$($theme.brightYellow)",
        "terminal.selectionBackground": "$($theme.selectionBackground)",
        "terminalCursor.foreground": "$($theme.cursorColor)"
    }
}
"@ > "../vscode/$($PSItem.Name)"
}


