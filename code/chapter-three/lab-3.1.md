# Lab 3.1

```sh
gpg --default-new-key-algo rsa4096 --gen-key

# generate key ID
gpg --list-secret-keys --keyid-format LONG
MY_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep "sec "| \
  cut -f2 -d'/' | cut -f1 -d' ')

# Check key ID
echo "My key id is ${MY_KEY_ID}"

# export your public key
gpg --armor --export ${MY_KEY_ID}

# get your public key ID
gpg --list-keys
gpg --list-keys | grep [A-Z] | grep -vF '[SC]'
MY_PUB_KEY=$(gpg --list-keys | grep [A-Z] | grep -vF '[SC]')

# Initialize your pass DB
pass init ${MY_PUB_KEY}
```

