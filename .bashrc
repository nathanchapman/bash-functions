# Open NPM
npmjs() {
    gitURL="$(git config --get remote.origin.url)"
    gitURL="${gitURL%.git}" # Remove .git from the end of the git URL
    if [[ ! -z $1 ]]; then
        module="$(echo $1 | tr '[:upper:]' '[:lower:]')" # Lowercase the module name for use with npm
        open https://www.npmjs.com/package/"$module"
    elif [[ $gitURL =~ ^git@ ]]; then
        gitURL="$(echo $gitURL | sed 's/git@//')" # Remove git@ from the start of the git URL
        repo="$(echo $gitURL | sed 's/.*\///')" # Pull the repo name from the git URL
        repo="$(echo $repo | tr '[:upper:]' '[:lower:]')" # Lowercase the repo for use with npm
        open https://www.npmjs.com/package/"$repo"
    elif [[ $gitURL =~ ^https?:// ]]; then
        repo="$(echo $gitURL | sed 's/.*\.com\///' | sed 's/.*\///')" # Pull the repo name from the git URL
        repo="$(echo $repo | tr '[:upper:]' '[:lower:]')" # Lowercase the repo for use with npm
        open https://www.npmjs.com/package/"$repo"
    else
        open https://www.npmjs.com/
    fi
    echo "📦 Opened npm in browser"
}

# Clone any repo and cd into it 
clone() {
    cloneUsage() {
        echo "\n⚠️  Usage:\nclone <url*> <dir>\nclone <org*>/<repo*> <dir>\nclone <org*> <repo*> <dir>\n* denotes required arguments"
    }

    gitClone() {
        CYAN="\033[1;36m"
        NOCOLOR="\033[0m"
        echo "🤖 Cloning $1"
        git clone $2 $directory && cd $directory || (cloneUsage && return 1)
        # If an error code was returned from the last command, return an error code
        if [[ "$?" == 1 ]]; then
            return 1
        fi
        echo "🚚 Moved to directory ${CYAN}$directory${NOCOLOR}"
    }

    if [[ -z $1 ]]; then
        cloneUsage
        return 1
    fi

    gitURL="$1"
    gitURL="${gitURL%.git}" # Remove .git from the end of the git URL
    if [[ $gitURL =~ ^git@ ]]; then
        gitURL="$(echo $gitURL | sed 's/git@//')" # Remove git@ from the start of the git URL
        org="$(echo $gitURL | sed 's/.*\://' | sed 's/\/.*//')" # Pull the org from the git URL
        repo="$(echo $gitURL | sed 's/.*\///')" # Pull the repo name from the git URL
        directory=${2:-"$repo"}
        gitClone "$org/$repo" $1
    elif [[ $gitURL =~ ^https?:// ]]; then
        # Force SSH
        github="$(echo $gitURL | cut -d'/' -f3)"
        org="$(echo $gitURL | sed 's/.*\.com\///' | sed 's/\/.*//')" # Pull the org from the git URL
        repo="$(echo $gitURL | sed 's/.*\.com\///' | sed 's/.*\///')" # Pull the repo name from the git URL
        directory=${2:-"$repo"}
        gitClone "$org/$repo" "git@$github:$org/$repo.git"
    elif [[ ! -z $1 && ! -z $2 && "$1" != *\/*  ]]; then
        directory=${3:-"$2"}
        gitClone "$1/$2" "git@github.com:$1/$2.git" # Replace with GitHub Enterprise URL (if applicable)
    else
        repo="$(echo $1 | sed 's/.*\///')"
        directory=${2:-"$repo"}
        gitClone "$1" "git@github.com:$1.git" # Replace with GitHub Enterprise URL (if applicable)
    fi
}

# Fork a GitHub repo
ghfork() {
    gitURL=${1:-"$(git config --get remote.origin.url)"}
    gitURL="${gitURL%.git}" # Remove .git from the end of the git URL
    if [[ $gitURL =~ ^git@ ]]; then
        gitURL="$(echo $gitURL | sed 's/git@//')" # Remove git@ from the start of the git URL
        repo="$(echo $gitURL | sed 's/.*\///')" # Pull the repo name from the git URL
    elif [[ $gitURL =~ ^https?:// ]]; then
        repo="$(echo $gitURL | sed 's/.*\.com\///' | sed 's/.*\///')" # Pull the repo name from the git URL
    elif [[ ! -z $1 && ! -z $2 && "$1" != *\/*  ]]; then
        repo="$2"
    else
        repo="$(echo $1 | sed 's/.*\///')"
    fi
    github "$@"
    echo "🍴 Click 'Fork'"
    user=$(whoami)
    print -z clone "$user" "$repo"
}

# Open GitHub
github() {
    gitURL="$(git config --get remote.origin.url)"
    gitURL="${gitURL%.git}" # Remove .git from the end of the git URL
    if [[ ! -z $1 && ! -z $2  ]]; then
        open https://github.com/"$1"/"$2" # Replace with GitHub Enterprise URL (if applicable)
    elif [[ $gitURL =~ ^git@ ]]; then
        branch=${1:-"$(git symbolic-ref --short HEAD)"}
        branchExists="$(git ls-remote --heads $gitURL $branch | wc -l)"
        github="$(echo $gitURL | sed 's/git@//')" # Remove git@ from the start of the git URL
        github="$(echo $github | sed 's/\:/\//')" # Replace the : between the URL and org with a / in the URL for GitHub
        if [[ $branchExists == "       1" ]]; then
            open http://"$github"/tree/"$branch"
        else
            open http://"$github"
        fi
    elif [[ $gitURL =~ ^https?:// ]]; then
        branch=${1:-"$(git symbolic-ref --short HEAD)"}
        branchExists="$(git ls-remote --heads $gitURL $branch | wc -l)"
        if [[ $branchExists == "       1" ]]; then
            open "$gitURL"/tree/"$branch"
        else
            open "$gitURL"
        fi
    else
        open https://github.com/"$1" # Replace with GitHub Enterprise URL (if applicable)
    fi
    echo "🐙 Opened GitHub in browser"
}

# Open the pull requests for a repo
pulls() {
    gitURL="$(git config --get remote.origin.url)"
    gitURL="${gitURL%.git}" # Remove .git from the end of the git URL
    if [[ ! -z $1 && ! -z $2 ]]; then
        open https://github.com/"$1"/"$2"/pulls # Replace with GitHub Enterprise URL (if applicable)
    elif [[ $gitURL =~ ^git@ ]]; then
        gitURL="$(echo $gitURL | sed 's/git@//')" # Remove git@ from the start of the git URL
        github="$(echo $gitURL | sed 's/\:/\//')" # Replace the : between the URL and org with a / in the URL for GitHub
        open http://"$github"/pulls
    elif [[ $gitURL =~ ^https?:// ]]; then
        open "$gitURL"/pulls
    else
        open https://github.com/pulls # Replace with GitHub Enterprise URL (if applicable)
    fi
    echo "🔃 Opened GitHub pull requests"
}

# Create a pull request for a repo
pr() {
    gitURL="$(git config --get remote.origin.url)"
    gitURL="${gitURL%.git}" # Remove .git from the end of the git URL
    if [[ $gitURL =~ ^git@ ]]; then
        gitURL="$(echo $gitURL | sed 's/git@//')" # Remove git@ from the start of the git URL
        github="$(echo $gitURL | sed 's/\:/\//')" # Replace the : between the URL and org with a / in the URL for GitHub
        branch="$(git symbolic-ref --short HEAD)"
        open http://"$github"/compare/${1:-master}...${2:-"$branch"}?expand=1
    elif [[ $gitURL =~ ^https?:// ]]; then
        branch="$(git symbolic-ref --short HEAD)"
        open "$gitURL"/compare/${1:-master}...${2:-"$branch"}?expand=1
    elif [[ ! -z $1 && ! -z $2 ]]; then
        open https://github.com/"$1"/"$2"/compare/${3:-master}...${4:-master}?expand=1 # Replace with GitHub Enterprise URL (if applicable)
    else
        echo "⚠️  Usage: pr <org*> <repo*> <base-branch> <branch-to-compare>"
        return 1
    fi
    echo "✏️  Creating GitHub pull request"
}

# Review and test a pull request for a repo
review() {
    git fetch origin pull/$1/head:${2:-$1}
    git checkout ${2:-$1}
}
