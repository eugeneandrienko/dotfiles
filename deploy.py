import argparse

from os import getcwd, listdir, path
from subprocess import call


CONFIG_DIRECTORIES_FILE = 'config_directories.txt'
HOME_DIRECTORY = path.expanduser("~")


def copy_dotfiles_to_home(dotfiles):
    call(['/bin/cp', '-R', dotfiles, HOME_DIRECTORY])
    print("%s copied." % (dotfiles))


def deploy_dotfiles():
    print("Copying dotfiles to %s directory..." % (HOME_DIRECTORY))
    with open(CONFIG_DIRECTORIES_FILE) as file:
        directories = file.read()
        for directory in directories.split('\n')[0:-1]:
            copy_dotfiles_to_home(
                getcwd() + path.sep + directory + path.sep)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--deploy", help="Deploy dotfiles to ~/",
                        action='store_true')
    args = parser.parse_args()

    if args.deploy:
        deploy_dotfiles()


if __name__ == "__main__":
    main()

