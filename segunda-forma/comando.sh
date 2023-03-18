
# enviamos como parametro el keyconfig queremos que se cargue
function ssh_git(){
    echo "Usando la segunda forma ... $1"
    export GIT_SSH_COMMAND="ssh -F ~/.ssh/keyconfig/$1"
}
