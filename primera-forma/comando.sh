 function ssh_git_1(){
     echo "Usando la primera forma ... $1"
     export GIT_SSH_COMMAND="ssh -i ~/.ssh/keys/$1"
}
