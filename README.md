# Server list

## Steps to export servers from controller to CSV file

1) Obtain controller connection details:
- Controller URL
- Temporary Access Token (API Access)

Create `.local.token` file and paste plaintext token value. 
> Never check-in or version control any of your access details.

2) Run server export

```console
foo@bar:~$ ./get-servers-list.sh https://<account-name>.saas.appdynamics.com
```

> Replace `<account-name>` with your controller's value.

3) Convert

```console
foo@bar:~$ ./convert-servers-list.sh
```

Find the latest server list in `/exported` folder.

4) Format CSV (optional)

Open file in Excel and navigate to Data tap > choose Text to Columns > use Comma as a separator > Finish

<img width="833" alt="Screenshot 2022-01-17 at 17 19 13" src="https://user-images.githubusercontent.com/82029748/149813819-1472086d-0582-4e5c-9971-46676a5ebee9.png">


