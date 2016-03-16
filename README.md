# How to set up a development machine

First, obtain the OpenCPU staging password (needed to access screensmart-r) by running this command:
`ssh -t 10.210.90.11 'sudo cat /var/www/screensmart.roqua-staging.nl/current/.env | grep OPENCPU_PASSWORD'`
Add a file .env.local, containing:
`OPENCPU_PASSWORD=<OPENCPU_PASSWORD of above command`

Then, as usual:
```bash
bundle
rails server
```
