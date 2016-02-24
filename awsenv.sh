#!/bin/bash -e

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFDIR="$THISDIR"
CONFFILE="$THISDIR/awsenv.conf"
TEMPDIR="$( mktemp -q -d -t tmp.XXXXXX )"

if [ -s $CONFFILE ]
    then
        source $CONFFILE
    else
	printf "Enter an identifier for PS1, blank if unsure: "
	read PS1_PREFIX
	printf "Enter default AWS region: "
	read AWS_DEFAULT_REGION
        printf "Enter AWS acces key ID: "
        read AWS_ACCESS_KEY_ID
        printf "Enter AWS secret access key: (will not echo) "
        read -s AWS_SECRET_ACCESS_KEY
	echo
	printf "Additional PyPI packages to include, space separated: "
	read PYPI_PACKAGES
	echo "PS1_PREFIX=$PS1_PREFIX" > $CONFFILE
	echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION" >> $CONFFILE
        echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> $CONFFILE
        echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> $CONFFILE
	echo "PYPI_PACKAGES=\"$PYPI_PACKAGES\"" >> $CONFFILE
fi

INITSTR="$TEMPDIR/virtualenv/virtualenv.py $TEMPDIR/awsenv --prompt=\"$PS1_PREFIX \" && \
         source $TEMPDIR/awsenv/bin/activate && \
         pip install awscli $PYPI_PACKAGES && \
         alias deactivate=exit && \
         export PATH=$THISDIR:$TEMPDIR/awsenv/bin:$PATH && \
         export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION && \
         export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID && \
         export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY && \
         if [ -s ~/.bashrc ]; then source ~/.bashrc; fi && \
	 if [ $SHELL == '/bin/bash' ]; then complete -C '$TEMPDIR/awsenv/bin/aws_completer' aws; fi && \
         echo"

git clone --depth 1 git@github.com:pypa/virtualenv.git $TEMPDIR/virtualenv

bash --init-file <(echo $INITSTR)

rm -rf $TEMPDIR
