# Bard_Gaming's Figura Lib

## Examples

## Installing BGLib

Whilst there aren't any particular requirements
to installing / using BG Lib in your own projects,
it is recommended you use a [Git Submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
if you're using Git when working on your avatar.

If you intend to use the library using a submodule,
all you need to do is run the following command:
```shell
git submodule add <repository> <path>
```
Where ``path`` is the path to where the directory should be cloned into.

The command will usually look as follows (when at the root of your repo):
```shell
git submodule add 'https://github.com/Bard-Gaming/Figura-Lib' lib
```
This will create a directory called ``lib/`` with bglib inside.

> [!IMPORTANT]
> When cloning a repository with a submodule,
> you should use the ``--recursive`` option to
> also clone the contents of the submodule.
> The command would then look as follows:
> ``git clone --recursive <repository> [<path>]``.

## Documentation

