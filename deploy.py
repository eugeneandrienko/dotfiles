import argparse


def check_for_installed_programs():
    pass


def deploy_dotfiles():
    pass


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--deploy", help="Deploy dotfiles to ~/",
                        action='store_true')
    args = parser.parse_args()

    if args.deploy:
        pass


if __name__ == "__main__":
    main()
