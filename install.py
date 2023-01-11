#!/usr/bin/env python3

import errno
import os
import shutil
import subprocess
import sys

from pathlib import Path


def link(source: Path, target: Path):
    abs_target = target.absolute()

    source.parent.mkdir(exist_ok=True)

    try:
        link_target = source.readlink()
        if link_target != abs_target:
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
    os.chdir(sys.path[0])

    home = Path.home()
    files = Path('files')

    if shutil.which('bat'):
        bat_dir = subprocess.check_output(('bat', '--config-dir')).rstrip()

        link(Path(os.fsdecode(bat_dir)), files / 'bat')

        subprocess.check_call(('bat', 'cache', '--build'))

    if shutil.which('foot'):
        link(home / '.config' / 'foot', files / 'foot')

    if shutil.which('git'):
        for f in ('gitconfig', 'gitconfig.delta', 'gitconfig.urls'):
            link(home / f'.{f}', files / 'git' / f)

        if os.name == 'nt':
            link(home / '.gitconfig.platform',
                 files / 'git' / 'gitconfig.windows')

    if shutil.which('gpg'):
        if os.name == 'nt':
            gpg_dir = Path(os.environ['APPDATA']) / 'gnupg'
        else:
            gpg_dir = home / '.gnupg'

        link(gpg_dir / 'gpg-agent.conf', files / 'gnupg' / 'gpg-agent.conf')

    if shutil.which('makepkg'):
        link(home / '.makepkg.conf', files / 'makepkg.conf')

    if shutil.which('mock'):
        link(home / '.config' / 'mock.cfg', files / 'mock.cfg')

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
            subprocess.check_call(('pwsh', '-c', pwsh_dir / 'env_vars.ps1'))

    if shutil.which('starship'):
        link(home / '.config' / 'starship.toml', files / 'starship.toml')

    if shutil.which('tmux'):
        for f in ('tmux.conf', 'tmux'):
            link(home / f'.{f}', files / f)

    if shutil.which('yt-dlp'):
        if os.name == 'nt':
            yt_dlp_dir = Path(os.environ['APPDATA']) / 'yt-dlp'
        else:
            yt_dlp_dir = home / '.config' / 'yt-dlp'

        link(yt_dlp_dir / 'config', files / 'yt-dlp' / 'config')

    if shutil.which('wezterm'):
        link(home / '.config' / 'wezterm', files / 'wezterm')

    if Path('/etc/arch-release').exists():
        link(home / '.config' / 'pinentry', files / 'pinentry')


if __name__ == '__main__':
    main()
