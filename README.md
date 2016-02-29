# awsenv.sh

*Ephemeral AWS CLI for embedding with version control*

If you want to install, use, and group an aws cli system together with a codebase you're working on,
then give the following a try. You'll need to have python 2 or 3, bash, and git installed within the context you're
running.

1. Download or clone the latest release of this software.
2. Run awsenv.sh and fill in stuff:

```
$ cd awsenv.sh
$ ./awsenv.sh
Enter an identifier for PS1, blank if unsure: myEnv
Enter default AWS region: eu-west-1
Enter AWS acces key ID: my_key_id
Enter AWS secret access key: (will not echo)
Additional PyPI packages to include, space separated:
```

When you're finished just type `exit` or hit `Ctrl-D`. The stuff you entered to start the awsenv was saved in
a file named `awsenv.conf`. `awsenv.sh` will only write and try to read the `awsenv.conf` residing in the same directory
as itself. Never commit `awsenv.conf` to version control as it contains your secret access key.