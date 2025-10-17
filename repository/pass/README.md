# PASS

## Initalization

Generate a gpg keys and create pass storage.

```sh
# Primary key
gpg --quick-generate-key "Joe (Comment here) <joe@example.com>" ed25519 cert 1y

# Get fingerprint of the Primary Key 
gpg --list-keys --keyid-format=long joe@example.com

# Subkey (this is what pass will actually use)
gpg --quick-add-key 572806BBA738A981C45E6C74AC743F5741E6C127 cv25519 encr 1y

# Create a new storage with given Subkey fingerprint
pass init 572806BBA738A981C45E6C74AC743F5741E6C127 -p subfolder
```

Details:
* Joe,Danny         - name (can be fake)
* (Comment here)    - comment (can be fake)
* <joe@example.com> - email (can be fake but must match with 'pass init')
* ed25519           - Curve25519 encryption  (sign/certify)
* cv25519           - Curve25519 encryption  (this is what pass will actually use)
* cert              - key usage: sign/certify 
* encr              - key usage: encryption
* 1y                - expiry time (1 year)
* -p a              - define storage subfolder


Why having "Primary key" and "Subkey" matters?
The pass only needs encryption capability. But OpenPGP doesn’t allow a bare 
encryption-only key without a parent — it must belong to an identity (a primary 
key).

Which Subkey will be used when there will be more for given Primary Key?
Pass uses file ~/.password-store/.gpg-id to determine it. Can be checked with:

```sh
gpg --list-packets ~/.password-store/test.com.gpg
```


## Backup

```sh
# Full export (primary + all subkeys)
gpg --armor --export-secret-keys -a joe@example.com > joe.key                                                                                                  │
# Subkeys only (recommended for moving to another machine safely)
gpg --armor --export-secret-subkeys danny@example.com > joe-subkeys.key                                                                                           │
```
