Import-Module -Name PSReadLine -Force
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None

oh-my-posh prompt init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/star.omp.json' | Invoke-Expression

Set-Alias vim nvim
Set-Alias v nvim

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

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


