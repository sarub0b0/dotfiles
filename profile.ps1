Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
Invoke-Expression (&starship init powershell)

Set-Alias vim nvim

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

function script:ghq_list () {
    ghq list | fzf
}


function gf () {
    $repo = $(script:ghq_list)
    if ( $LastExitCode -eq 0 ) {
        Set-Location "$(ghq root)/$repo"
    }
}


