# Dotfiles

Personal macOS configuration files, package manifests, and setup scripts, managed with 
[Git](https://github.com/git/git), [Homebrew](https://github.com/Homebrew/brew), and [GNU Stow](https://www.gnu.org/software/stow/).

![](https://github.com/user-attachments/assets/1d009c0a-2349-4fa0-8b89-523561dd43b9)

## Highlights

- Shell: Zsh
- Editor: Neovim
- Terminal: Ghostty
- Window manager: Aerospace
- Package management: Homebrew

## Setting up a new macOS machine

### Setup SSH and clone the repo

#### Generating a new SSH key
1. Create a new SSH key, using email as a label
    ```sh
    read -r "comment?Email for SSH key comment: " && ssh-keygen -t ed25519 -C "$comment"
    ```

#### Adding the SSH key to the ssh-agent
1. Start the ssh-agent in the background
    ```sh
    eval "$(ssh-agent -s)"
    ```

2. Modify `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in the keychain.
  - If the file doesn't exist, create the file
    ```sh
    touch ~/.ssh/config
    ```
  - Open the file
    ```sh
    open ~/.ssh/config
    ```
  - Add the following
    ```sh
    Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
    ```
3. Add the SSH private key to the ssh-agent and store the passphrase in the keychain

    ```sh
    ssh-add -K ~/.ssh/id_ed25519
    ```

#### Adding the SSH key to the GitHub account
1. Copy the SSH public key to your clipboard.
    ```sh
    pbcopy < ~/.ssh/id_ed25519.pub
    ```

2. Add *New SSH key* in [GitHub Settings](https://github.com/settings/keys)

#### Clone this repo

```sh
mkdir Developer; cd Developer
```
```sh
git clone --recurse-submodules git@github.com:alesker/dotfiles.git; cd dotfiles
```

### Install stuff with [Homebrew](https://brew.sh)

#### Run the install script

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

> :shipit: Don't forget to execute **`Next steps`** after Homebrew is installed

#### Install dependencies via Homebrew

```sh
brew bundle --file brewfiles/general.Brewfile
```
```sh
brew bundle --file brewfiles/development.Brewfile
```

Bundle other brewfiles depending on the machine (personal, work, etc.)

> :shipit: Don't forget to run `brew caveats` for every brewfile and follow instructions when necessary

### Set up configurations 

#### Link configs packages with GNU Stow

```sh
stow aerospace bat fzf ghostty gir htop karabiner lazygit mise nvim treehouse tuicr yazi zsh
```

#### Add .gitconfig linked with .gitconfig-dotfiles

```sh
read -r "name?Name: " && \
read -r "email?Email: " && \
git config --global user.name "$name" && \
git config --global user.email "$email" && \
git config --global include.path '~/.gitconfig-dotfiles'
```

#### Install dev tools

```sh
mise install
```

#### Add local and organization-specific configurations

##### .zshrc

```sh
ln -s "$(pwd)/<local_zshrc_file>" ~/.custom-zshrc
```

##### mise

```sh
ln -s "$(pwd)/<local_mise_config_file>.toml" ~/.config/mise/config.local.toml
```

> :shipit: Don't forget to run `mise install` to install local dev tools

##### git

```sh
read -r "organization?Organization: " && \
git config --global "includeIf.gitdir:~/Developer/$organization/.path" "~/.gitconfig-$organization"
```

### Scripts

- bootstrap environment
- change system and tooling defaults (use `--help` to see available commands)
- link additional tools
