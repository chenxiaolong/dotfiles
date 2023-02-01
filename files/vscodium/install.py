#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('executable', help='VSCodium executable')
    args = parser.parse_args()

    with open(os.path.join(sys.path[0], 'extensions.txt')) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue

            subprocess.check_call([
                args.executable,
                '--install-extension', line,
            ])


if __name__ == '__main__':
    main()
