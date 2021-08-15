## Setup (Lab 3b)

Once you have created the lab container image in the previous lab, you can attempt the steps below.
While it is not strictly necessary to perform these steps in a Docker container, it will prevent
you from altering your workstation in ways that might be difficult to reverse later.

### Generate a new GPG Key Pair

    gpg --default-new-key-algo rsa4096 --gen-key

### Work with Key ID

    # view your key ID
    gpg --list-secret-keys --keyid-format LONG
    # export your key ID as an environment variable
    MY_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep "sec "| \
      cut -f2 -d'/' | cut -f1 -d' ')

### Check key ID
    
    echo "My key id is ${MY_KEY_ID}"

### Export your Public Key

    gpg --armor --export ${MY_KEY_ID}

### Get your Public key ID

    gpg --list-keys
    gpg --list-keys | grep [A-Z] | grep -vF '[SC]'
    MY_PUB_KEY=$(gpg --list-keys | grep [A-Z] | grep -vF '[SC]')

### Initialize your pass DB

Now that we have a GPG key pair ready, we can initialize the `pass` database to store
our secrets in.

    pass init ${MY_PUB_KEY}

Note that the `pass` command is installed to the container when you build the image in the 
previous lab.

