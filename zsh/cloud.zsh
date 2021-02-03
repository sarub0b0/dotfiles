__kubectl_prompt_color() {
    [[ "$ZSH_KUBECTL_USER" =~ "admin" ]] && color=red || color=blue
    echo "$color"
}

__read_zsh_prompt () {
    if [ -f $HOME/.zsh-kubectl-prompt/kubectl.zsh ]; then
        source $HOME/.zsh-kubectl-prompt/kubectl.zsh
    fi
    if [ -f $HOME/.zsh-gcloud-prompt/gcloud.zsh ]; then
        source $HOME/.zsh-gcloud-prompt/gcloud.zsh
    fi
}

kubectl-enable () {
    __read_zsh_prompt

    PROMPT=$'%{$fg[$(__kubectl_prompt_color)]%}gcp: $ZSH_GCLOUD_PROMPT\nk8s: ($ZSH_KUBECTL_CONTEXT:$ZSH_KUBECTL_NAMESPACE)\n'"$PROMPT"
    zle reset-prompt
}

kubectl-disable () {
    __default_prompt
    zle reset-prompt
}


pf_argo_prod () {
    local port=$1
    kubectl port-forward -n argocd --context gke_pro-bbtower-portal_asia-northeast1_pro-portal-cluster svc/argocd-server $port:443 &
    while (true);
    do
        curl localhost:$port -s > /dev/null;
        sleep 30;
    done
}

pf_argo_dev () {
    local port=$1
    kubectl port-forward -n argocd --context gke_dev-bbtower-portal_asia-northeast1-a_dev-portal-cluster svc/argocd-server $port:443 &
    while (true);
    do
        curl localhost:$port -s > /dev/null;
        sleep 30;
    done
}


kwatch () {
    local resource=""
    local namespace=""
    if [ -z "$1" ]; then
        resource="all,ing,secret,es,cm,pvc,pv"
    else
        resource=$1
    fi

    if [ -n "$2" ]; then
        namespace="-n $2"
    fi


    watch kubectl get $resource $namespace
}

ktop () {
    local target="pod"
    if [ -z "$1" ]; then
        target=pod
    else
        target=$1
    fi
    watch kubectl top $target
}

if builtin command -v kubectl > /dev/null; then
    kubectl() {
        unfunction "$0"
        source <(kubectl completion zsh)
        $0 "$@"
    }
fi

kgetall () {
    list=$(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq )

    for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq );
    do
        resource=$(kubectl get --ignore-not-found ${i})
        if ! [ -z "$resource" ]; then
            echo "Resource: " ${i}
            echo "$resource"
        fi
    done
    unset i
}

# PROMPT
zle -N kubectl-enable kubectl-enable
zle -N kubectl-disable kubectl-disable
bindkey '^G^M' kubectl-enable
bindkey '^G^N' kubectl-disable

