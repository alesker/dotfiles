# Setup new macOS machine

## Setup SSH and clone the repo

### Generating a new SSH key
1. Create a new SSH key, using email as a label
`ssh-keygen -t ed25519 -C "your_email@example.com"`

### Adding the SSH key to the ssh-agent
1. Start the ssh-agent in the background

    `eval "$(ssh-agent -s)"`

2. Modify `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in the keychain.
  - If the file doesn't exist, create the file
   
      `touch ~/.ssh/config`
  
  - Open the file
      
      `open ~/.ssh/config`
      
  - Add the following
  
      ```
      Host *
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519
      ```
      
3. Add the SSH private key to the ssh-agent and store the passphrase in the keychain

    `ssh-add -K ~/.ssh/id_ed25519`
    

### Adding the SSH key to the GitHub account
1. Copy the SSH public key to your clipboard.

    `pbcopy < ~/.ssh/id_ed25519.pub`

2. Add *New SSH key* in [GitHub Settings](https://github.com/settings/keys)

### Clone this repo

`mkdir Developer; cd Developer`

`git clone git@github.com:alesker/config.git`

## Install [Homebrew](https://brew.sh)

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

> :shipit: Don't forget to execute **`Next steps`** after Homebrew is installed

## Install dependencies via Homebrew

`brew bundle --file brewfiles/general.Brewfile`

`brew bundle --file brewfiles/development.Brewfile`


## Install [Oh My Zsh](https://ohmyz.sh/)

`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

## Link configs with GNU Stow

`stow zsh ghostty nvim htop -t ~ --verbose=2`

## Plug any local zsh config to the main .zshrc
`ln -s "$(pwd)/<local_zshrc_file>" ~/.custom-zshrc`


