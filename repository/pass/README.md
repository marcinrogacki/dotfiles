# PASS

## Cheatsheet

```sh
# Generate a primary key (one line command - no user action needed)
gpg --quick-generate-key "Joe (Comment here) <joe@example.com>" ed25519 cert 1y

# Generate a subkey (used by pass for encryption)
gpg --quick-add-key E2390357F706AF728D3541368470DDB9B8591B1D cv25519 encr 1y

# Create a new storage. Pass key fingerprint as param
pass init E2390357F706AF728D3541368470DDB9B8591B1D -p work

# Enable git
PASSWORD_STORE_DIR=~/.password-store/work pass git init

# Get fingerprint/ids of the keys
gpg --list-keys --keyid-format=long joe@example.com

# Check which subkey was used to encrypt given file
gpg --list-packets ~/.password-store/test.com.gpg

# Export everything (primary + all subkeys)
gpg --armor --export-secret-keys -a joe@example.com > joe.key

# Export all subkeys, recommended for moving to another machine safely. 
gpg --armor --export-secret-subkeys joe@example.com > joe-subkeys.key

# Export a single subkey. Note '!' at the end of key id, which is important.
gpg --export --armor --output joe-subkey.key DF9FC7E2BE875F8A!

# Import
gpg --import joe.key

# Re-encrypt storage with a new key. Use when:
# * a new private key or subkey need to be used (old is compromised)
# * a private key or subkey has expired 
pass init E2390357F706AF728D3541368470DDB9B8591B1D -p work

# Create encrypted directory to hide file names created by pass
gocryptfs -init ~/.password-store-encrypted/

# Mount encrypted storage
gocryptfs ~/.password-store-encrypted ~/.password-store

# Unmount encrypted storage
fusermount3 -u ~/.password-store

# Copy password to new directory. Re-encrypt when a new directory uses different GPG key.
pass cp work/test.com personal/
```

Details:
* Joe               - name
* (Comment here)    - comment
* <joe@example.com> - email
* ed25519           - Curve25519 encryption  (sign/certify)
* cv25519           - Curve25519 encryption  (this is what pass will actually use)
* cert              - key usage: sign/certify 
* encr              - key usage: encryption
* 1y                - expiry time (1 year)
* -p work           - define storage (subdirectory) called "work"
* --armor           - Human-readable text format using Base64 encoding 

## Docs

https://git.zx2c4.com/password-store/about/
* Environment variables

## Tree structure 

```
~/.pass-storage/            # decrypted view (used by pass)
└── work/                   # substore with its own key
    ├── .gpg-id                 # GPG key fingerprint(s) used for encryption
    └── example.com.gpg           # encrypted password entry

~/.pass-storage-encrypted/  # encrypted physical storage (gocryptfs backend)
├── gocryptfs.conf          # encryption parameters (cipher, hash, KDF)
├── gocryptfs.diriv         # directory IV for root
└── ZXCV3210.../            # encrypted folder name for work/
    ├── gocryptfs.diriv     # IV for work folder
    ├── WERF2390...         # encrypted example.com.gpg
    └── TGJU4561...         # encrypted .gpg-id
```

## Android

Install F-Droid https://f-droid.org/en/ 
Install Password Store via F-Droid (see https://github.com/agrahn/Android-Password-Store)
Export GPG subkeys and import them Password Store on Android
Import storage by using Setting -> Repository -> Import Repository. Do not setup repository url. 

## Q&A

### Why having primary key and subkey matters?

The pass only needs encryption capability. But OpenPGP doesn’t allow a bare 
encryption-only key without a parent — it must belong to an identity (a primary 
key).

### Which subkey will be used when there will be more for given primary key?

pass uses file ~/.password-store/.gpg-id to determine it.

### What if encryption key will expire?

Storage can be read, but no more entries can be inserted. Expired key is not 
listed in gpg keyring. Generate a new key/subkey and re-encrypt the storage. 

