# Server list

## Steps to use Health rules
1) Obtain controller connection details:
- Controller URL
- Access Token (API Access)

Create .local.token file and paste plaintext token value. 
> Never check-in or version control any of your access details.

2) Run server export

```console
foo@bar:~$ ./get-servers-list.sh https://<account-name>.saas.appdynamics.com
```

> Note: replace <account-name> with your controller's value.

3) Convert

```console
foo@bar:~$ ./convert-servers-list.sh
```

Find the latest server list in '/exported' folder.