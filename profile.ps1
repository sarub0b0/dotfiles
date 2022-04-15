Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs


Set-Alias vim nvim

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

function script:ghq_list () {
    $env:FZF_DEFAULT_OPTS = '--height 40% --layout=reverse --border'

    if (Get-Command bat -ea SilentlyContinue) {
        ghq list | fzf --preview "bat $(ghq root)/{}/README.*"
    }
    else {
        ghq list | fzf
    }
}

function gf () {
    $repo = $(script:ghq_list)
    if ( $LastExitCode -eq 0 ) {
        Set-Location "$(ghq root)/$repo"
    }
}


