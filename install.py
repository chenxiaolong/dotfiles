#!/usr/bin/env python3

import errno
import os
import shutil
import subprocess
import sys

from pathlib import Path


LONG_PATH_PREFIX = '\\\\?\\'


if os.name == 'nt':
    def long_path(p):
        p_str = os.fspath(p)
        if not p_str.startswith(LONG_PATH_PREFIX):
            p = Path(LONG_PATH_PREFIX + p_str)

        return p


def paths_equal(a, b):
    if os.name == 'nt':
        return long_path(a) == long_path(b)
    else:
        return a == b


def link(source: Path, target: Path):
    abs_target = target.absolute()

    source.parent.mkdir(parents=True, exist_ok=True)

    try:
        link_target = source.readlink()
        if not paths_equal(abs_target, link_target):
            raise Exception(
                f'{source}: path exists, but is symlinked to {link_target}')

        print(f'{source}: path is already correctly linked')
    except FileNotFoundError:
        print(f'{source}: symlinking to {abs_target}')
        source.symlink_to(abs_target)
    except OSError as e:
        if e.errno == errno.EINVAL:
            raise Exception(f'{source}: path exists, but is not a symlink') \
                from e
        else:
            raise e


def main():
    home = Path.home()
    dotfiles = Path(sys.path[0])
    files = dotfiles / 'files'

    if shutil.which('alacritty'):
        link(home / '.config' / 'alacritty', files / 'alacritty')

    if shutil.which('bat'):
        bat_dir = subprocess.check_output(('bat', '--config-dir')).rstrip()

        link(Path(os.fsdecode(bat_dir)), files / 'bat')

        subprocess.check_call(('bat', 'cache', '--build'))

    if shutil.which('codium'):
        if os.name == 'nt':
            codium_dir = Path(os.environ['APPDATA']) / 'VSCodium'
        else:
            codium_dir = home / '.config' / 'VSCodium'

        for f in ('keybindings.json', 'settings.json'):
            link(codium_dir / 'User' / f, files / 'vscodium' / f)

        link(codium_dir / 'product.json', files / 'vscodium' / 'product.json')

    if shutil.which('foot'):
        link(home / '.config' / 'foot', files / 'foot')

    if shutil.which('git'):
        for f in ('gitconfig', 'gitconfig.urls'):
            link(home / f'.{f}', files / 'git' / f)

        if shutil.which('delta'):
            link(home / '.gitconfig.delta', files / 'git' / 'gitconfig.delta')

        if os.name == 'nt':
            link(home / '.gitconfig.platform',
                 files / 'git' / 'gitconfig.windows')

    if shutil.which('gpg'):
        if os.name == 'nt':
            gpg_dir = Path(os.environ['APPDATA']) / 'gnupg'
        else:
            gpg_dir = home / '.gnupg'

        link(gpg_dir / 'gpg-agent.conf', files / 'gnupg' / 'gpg-agent.conf')

    if shutil.which('konsole'):
        kcs = 'base16-tomorrow-night.colorscheme'

        link(home / '.local' / 'share' / 'konsole' / kcs,
             dotfiles / 'submodules' / 'base16-konsole' / 'colorscheme' / kcs)
        link(home / '.local' / 'share' / 'konsole' / 'main.profile',
             files / 'konsole' / 'main.profile')

    if shutil.which('makepkg'):
        link(home / '.makepkg.conf', files / 'makepkg.conf')

    if shutil.which('mock'):
        link(home / '.config' / 'mock.cfg', files / 'mock.cfg')

    if shutil.which('mpv'):
        if os.name == 'nt':
            mpv_dir = Path(os.environ['APPDATA']) / 'mpv'
        else:
            mpv_dir = home / '.config' / 'mpv'

        link(mpv_dir, files / 'mpv')

    if shutil.which('nvim'):
        if os.name == 'nt':
            nvim_dir = Path(os.environ['LOCALAPPDATA']) / 'nvim'
        else:
            nvim_dir = home / '.config' / 'nvim'

        link(nvim_dir, files / 'nvim')

    if shutil.which('pwsh'):
        if os.name == 'nt':
            pwsh_dir = home / 'Documents' / 'PowerShell'
        else:
            pwsh_dir = home / '.config' / 'powershell'

        link(pwsh_dir / 'profile.ps1', files / 'pwsh' / 'profile.ps1')

        if os.name == 'nt':
            subprocess.check_call(('pwsh', '-c',
                                   files / 'pwsh' / 'env_vars.ps1'))

    if shutil.which('starship'):
        link(home / '.config' / 'starship.toml', files / 'starship.toml')

    if shutil.which('tmux'):
        for f in ('tmux.conf', 'tmux'):
            link(home / f'.{f}', files / f)

    if shutil.which('wezterm'):
        link(home / '.config' / 'wezterm', files / 'wezterm')

    if shutil.which('yt-dlp'):
        if os.name == 'nt':
            yt_dlp_dir = Path(os.environ['APPDATA']) / 'yt-dlp'
        else:
            yt_dlp_dir = home / '.config' / 'yt-dlp'

        link(yt_dlp_dir / 'config', files / 'yt-dlp' / 'config')

    if Path('/etc/arch-release').exists():
        link(home / '.config' / 'pinentry', files / 'pinentry')


if __name__ == '__main__':
    main()
