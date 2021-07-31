# Lab 3.1

```sh
gpg --default-new-key-algo rsa4096 --gen-key

MY_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec| \
  cut -f2 -d'/' | cut -f1 -d' ')

echo "My key id is ${MY_KEY_ID}"
gpg --armor --export ${MY_KEY_ID}
```

