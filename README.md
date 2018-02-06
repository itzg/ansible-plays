## Example

### Prepare admin/ansible user

This will setup `GROUP` machines by ssh'ing as `REMOTE_USER` with the SSH private key/identity
file `KEY_FILE`. It will prompt for the sudo'ing password.

```bash
ansible-playbook -b -K -i inventory.yml -l GROUP -u REMOTE_USER --key-file=KEY_FILE prep.yml
```

If you have the root identity file, just use

```bash
ansible-playbook -i inventory.yml -l GROUP -u root --key-file=KEY_FILE prep.yml
```


```bash
ansible-playbook -i inventory.yml -u itzg site.yml
```