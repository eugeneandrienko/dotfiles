import argparse

from distutils.dir_util import copy_tree
from os import getcwd, listdir, path
from shutil import copy


CONFIG_DIRECTORIES_FILE = 'config_directories.txt'
HOME_DIRECTORY = path.expanduser("~")


def copy_dotfile_to_home(dotfile):
    if path.isfile(dotfile):
        copy(dotfile, HOME_DIRECTORY, follow_symlinks=False)
        print("%s copied." % (dotfile))
    else:
        copy_tree(dotfile, HOME_DIRECTORY, preserve_symlinks=True)
        print("%s/ copied." % (dotfile))


def deploy_dotfiles():
    print("Copying dotfiles to %s directory..." % (HOME_DIRECTORY))
    with open(CONFIG_DIRECTORIES_FILE) as file:
        directories = file.read()
        for directory in directories.split('\n')[0:-1]:
            for dotfile in listdir(directory):
                copy_dotfile_to_home(
                    getcwd() + path.sep + directory + path.sep + dotfile)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--deploy", help="Deploy dotfiles to ~/",
                        action='store_true')
    args = parser.parse_args()

    if args.deploy:
        deploy_dotfiles()


if __name__ == "__main__":
    main()
