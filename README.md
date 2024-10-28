# Sascha's UNIX/Linux shell environment (aka dotfiles)

Includes oh-my-zsh, no fuzz and personal taste. Uses chezmoi 
for 3rd-party cool stuff such as managing oh-my-zsh.

## Bootstrapping

Install chezmoi with your package manager or use the script:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)"
```

Then, initialize from this Github repository with:

```shell
chezmoi init --apply saschpe
```

## Vundle

Vim plugins are managed with Vundle. Set it up by running:

    $ ./bin/vundle
