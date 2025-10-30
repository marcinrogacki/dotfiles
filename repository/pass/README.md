# PASS

## Cheatsheet

```sh
# Generate a primary key
gpg --quick-generate-key "Joe (Comment here) <joe@example.com>" ed25519 cert 1y

# Generate a subkey (used by pass for encryption)
gpg --quick-add-key E2390357F706AF728D3541368470DDB9B8591B1D cv25519 encr 1y

# Create a new storage. Pass key fingerprint as param
pass init E2390357F706AF728D3541368470DDB9B8591B1D -p subfolder

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
pass init E2390357F706AF728D3541368470DDB9B8591B1D -p subfolder
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
* -p subfolder      - define storage subfolder

## Q&A

### Why having primary key and subkey matters?
The pass only needs encryption capability. But OpenPGP doesn’t allow a bare 
encryption-only key without a parent — it must belong to an identity (a primary 
key).

### Which subkey will be used when there will be more for given primary key?
Pass uses file ~/.password-store/.gpg-id to determine it.

### What if encryption key will expire?
Storage can be read, but no more entries can be inserted. Expired key is not 
listed in gpg keyring. Generate a new key/subkey and re-encrypt the storage. 
