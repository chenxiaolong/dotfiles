#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('executable', help='VSCodium executable')
    args = parser.parse_args()

    desired = set()

    with open(os.path.join(sys.path[0], 'extensions.txt')) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue

            desired.add(line)

    actual = set(subprocess.check_output([
        args.executable,
        '--list-extensions',
    ]).decode('ascii').splitlines())

    for ext in actual - desired:
        subprocess.check_call([
            args.executable,
            '--uninstall-extension', ext,
        ])
    # DELETE

    for ext in desired - actual:
        subprocess.check_call([
            args.executable,
            '--install-extension', ext,
        ])


if __name__ == '__main__':
    main()
