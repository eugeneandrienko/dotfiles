import argparse

from os import getcwd, listdir, path, rename, symlink
from subprocess import check_call, CalledProcessError, TimeoutExpired, DEVNULL


REQUIREMENTS_FILE = 'requirements.txt'
CONFIG_DIRECTORIES_FILE = 'config_directories.txt'


def check_program(binary_name):
    print("Checking for %s: " % binary_name, end='')
    try:
        check_call([binary_name], stdout=DEVNULL, stderr=DEVNULL,
                   timeout=1, shell=False)
    except CalledProcessError:
        check_call([binary_name, '--help'], stdout=DEVNULL, stderr=DEVNULL,
                   timeout=1, shell=False)
    except TimeoutExpired:
        pass  # all is ok, we execute command and it is does not return to
        # shell.

    print("installed")


def check_for_installed_programs(requirements_file):
    print("Checking installed programs...")
    with open(requirements_file) as file:
        requirements = file.read()
        for requirement in requirements.split('\n')[0:-1]:
            check_program(requirement)


def make_link_to_dotfile(dotfile, symlink_path):
    print("%s => %s: " % (dotfile, symlink_path), end='')
    if path.lexists(symlink_path):
        print("exists", end='')
        try:
            print(" making backup", end='')
            rename(symlink_path, symlink_path + '.bak')
        except OSError:
            pass

    symlink(dotfile, symlink_path)
    print(" done")


def deploy_dotfiles():
    print("Making symlinks to dotfiles...")
    with open(CONFIG_DIRECTORIES_FILE) as file:
        directories = file.read()
        for directory in directories.split('\n')[0:-1]:
            for dotfile in listdir(directory):
                make_link_to_dotfile(
                    getcwd() + path.sep + directory + path.sep + dotfile,
                    path.expanduser('~') + path.sep + dotfile)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--deploy", help="Deploy dotfiles to ~/",
                        action='store_true')
    args = parser.parse_args()

    if args.deploy:
        try:
            check_for_installed_programs(REQUIREMENTS_FILE)
        except (CalledProcessError, FileNotFoundError):
            print("not installed!")
            exit(1)
        deploy_dotfiles()


if __name__ == "__main__":
    main()
