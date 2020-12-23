# 🔮 bash-functions

A collection of useful Bash/ZSH functions. Just drop the functions from [.bashrc](.bashrc) at the end of your `.bashrc` or `.zshrc`. These work great with the [MacBook touch bar](#-iterm2-touch-bar-support) and [iTerm2](https://www.iterm2.com/).

## Usage

### 📦 Open a module on npmjs.com

From anywhere:

```bash
npmjs # opens npmjs.com
npmjs <module> # opens npmjs.com for npm module <module>
```

From a git repo:

```bash
npmjs # opens npmjs.com for npm module <git-repo>
```

### 🤖 Clone any repo and 🚚 cd into it

From anywhere:

```bash
clone url # clone a repo from any git URL and cd into it
clone org repo # clone a repo from GitHub and cd into it
clone org/repo # clone a repo from GitHub and cd into it
```

### 🍴 Fork a GitHub repo

From anywhere:

```bash
ghfork url # fork a repo from any GitHub URL and cd into it
ghfork org repo # fork from GitHub and cd into it
ghfork org/repo # fork from GitHub and cd into it
```

### 🐙 Open GitHub

From anywhere:

```bash
github # opens GitHub
github org # opens GitHub for org
github org/repo # opens GitHub for org/repo
github org repo # opens GitHub for org/repo
```

From a git repo:

```bash
github # opens this repo in GitHub for current branch
github <branch> # opens this repo in GitHub for specified branch
```

### 🔃 Open the pull requests for a repo

From anywhere:

```bash
pulls # opens GitHub for all pull requests for user
pulls org repo # opens GitHub for all pull requests for org/repo
```

From a git repo:

```bash
pulls # opens GitHub for all pull requests for this repo
```

### ✏️ Create a pull request for a repo

From anywhere:

```bash
pr <org> <repo> <base> <branch> # opens GitHub to draft a pull request in org/repo to merge <branch> into <base>
```

From a git repo:

```bash
pr # opens GitHub to draft a pull request in this repo to merge the current branch into master
pr <base> # opens GitHub to draft a pull request in this repo to merge the current branch into <base>
pr <base> <branch> # opens GitHub to draft a pull request in this repo to merge <branch> into <base>
```

### 🔬 Review and test a pull request for a repo

From a git repo:

```bash
review <number> # checks out PR #<number> into a local branch named <number> for review/testing
review <number> <branch> # checks out PR #<number> into a local branch named <branch> for review/testing
```

## 💻 iTerm2 Touch Bar Support

![iTerm2 Touch Bar](./assets/iterm2-touch-bar.png)

In iTerm2, navigate to `Preferences` > `Keys` and `Add Touch Bar Item` for each of the following items. After, navigate to the `View` dropdown > `Customize Touch Bar...` and drag them where you'd like 😎.

### Npm

Label: `📦`

Action: `Send Text with "vim" Special Chars`

`npmjs\r`

### Clone

Label: `🤖`

Action: `Send Text`

`clone YourOrg `

### VS Code / Atom / Sublime

Label: `🚧` or `🔭` or `👩‍💻` or `👨‍💻` or `⚛️`

Action: `Send Text with "vim" Special Chars`

`code .\r` or `atom .\r` or `subl .\r`

### Git Pull

Label: `👇`

Action: `Send Text with "vim" Special Chars`

`git pull\r`

### Git Push

Label: `👆`

Action: `Send Text`

`git push `

### GitHub

Label: `🐙`

Action: `Send Text with "vim" Special Chars`

`github\r`

### Git Status

Label: `📟`

Action: `Send Text with "vim" Special Chars`

`gst\r`

### Npm Install

Label: `📀`

Action: `Send Text with "vim" Special Chars`

`npm i\r`

### Npm Start

Label: `⚡️` or `🏁`

Action: `Send Text with "vim" Special Chars`

`npm start\r`

### Npm Test

Label: `🔬`

Action: `Send Text with "vim" Special Chars`

`npm t\r`

### Draft PR

Label: `✏️`

Action: `Send Text with "vim" Special Chars`

`pr\r`

### View PRs

Label: `🔃`

Action: `Send Text with "vim" Special Chars`

`pulls\r`

### Spotify Play/Pause

NOTE: Requires [shpotify](https://github.com/hnarayanan/shpotify).

Label: `🎸` or `🎧` or `🎵` or `🎷`

Action: `Send Text with "vim" Special Chars`

`spotify pause\r`

## Sponsorship 🎗

If you found this project useful, please consider becoming a [sponsor on GitHub](https://github.com/sponsors/nathanchapman).
