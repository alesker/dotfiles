# Setup new macOS machine
![](https://github.com/user-attachments/assets/1d009c0a-2349-4fa0-8b89-523561dd43b9)

## Setup SSH and clone the repo

### Generating a new SSH key
1. Create a new SSH key, using email as a label
    ```
    ssh-keygen -t ed25519 -C "ilya.alesker@gmail.com"
    ```

### Adding the SSH key to the ssh-agent
1. Start the ssh-agent in the background
    ```
    eval "$(ssh-agent -s)"
    ```

2. Modify `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in the keychain.
  - If the file doesn't exist, create the file
    ```
    touch ~/.ssh/config
    ```
  - Open the file
    ```
    open ~/.ssh/config
    ```
  - Add the following
    ```
    Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
    ```
3. Add the SSH private key to the ssh-agent and store the passphrase in the keychain

    ```
    ssh-add -K ~/.ssh/id_ed25519
    ```

### Adding the SSH key to the GitHub account
1. Copy the SSH public key to your clipboard.
    ```
    pbcopy < ~/.ssh/id_ed25519.pub
    ```

2. Add *New SSH key* in [GitHub Settings](https://github.com/settings/keys)

### Clone this repo

```
mkdir Developer; cd Developer
```
```
git clone git@github.com:alesker/config.git
```

## Install stuff with [Homebrew](https://brew.sh)

### Run the install script

```
bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

> :shipit: Don't forget to execute **`Next steps`** after Homebrew is installed

### Install dependencies via Homebrew

```
brew bundle --file brewfiles/general.Brewfile
```
```
brew bundle --file brewfiles/development.Brewfile
```

Bundle other brewfiles depending on the machine (personal, work, etc.)

> :shipit: Don't forget to run `brew caveats` for every brewfile and follow instructions when necessary

## Link configs with GNU Stow

```
stow zsh aerospace nvim ghostty yazi htop
```

## Plug any local zsh config to the main .zshrc
```
ln -s "$(pwd)/<local_zshrc_file>" ~/.custom-zshrc
```

## Scripts

Set correct permissions for scripts
```
chmod 755 ./scripts/*
```

and run them to 
- bootstrap environment
- change system and tooling defaults (use `--help` to see available commands)
- link additional tools

