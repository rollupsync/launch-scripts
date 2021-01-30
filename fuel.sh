#!/bin/sh

set -e

echo "Enter the path where data should be stored:"
read DATA_DIR

if [ -f $DATA_DIR ]
then
  echo "Normal file exists at $DATA_DIR"
  exit 1
elif [ -d $DATA_DIR ]
then
  echo "Directory already exists, continue (y/n)?"
  read CONT
  if [ $CONT != "y" ]
  then
    echo "Aborted"
    exit 0
  fi
else
  mkdir $DATA_DIR
fi

cd $DATA_DIR
git clone https://github.com/rollupsync/verifiers.git

sh -c "cd verifiers ; npm i"

node verifiers/scripts/create_wallet.js
node verifiers/scripts/generate_dockerfile.js mainnet wallet.enc.json wallet_password.secret

echo 'Setup complete, start the service using "docker-compose up"'
