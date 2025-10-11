# pratik.nvim
## Neovim setup based on my use cases (plugins inclusive)

### Installation

```sh
cd $XDG_CONFIG_HOME
git clone https://github.com/FireDrop6000/pratik.nvim.git nvim

cd nvim
```

## Updating

You can update by running `git pull` in `$XDG_CONFIG_HOME/nvim`.

```sh
cd $XDG_CONFIG_HOME/nvim
git pull
```

> [!NOTE]
> Java support used to be a part of the config too. However, loading all Java files on nvim startup each time was rendering my machine slow (and I have a crappy old laptop) so I had to delete it. However if you want to get Java support I recommend watching this [video](https://www.youtube.com/watch?v=zbpF3te0M3g) by Unknown Koder. The video covers upto extensive Java support until Spring Boot. If you want a quicker JDTLS setup you can follow my [gist](https://gist.github.com/FireDrop6000/c8786b392b0a37ea52c8f679841cd912)
