[![Circle CI](https://circleci.com/gh/roqua/screensmart.svg?style=svg)](https://circleci.com/gh/roqua/screensmart)
[![Issue Count](https://codeclimate.com/github/roqua/screensmart/badges/issue_count.svg)](https://codeclimate.com/github/roqua/screensmart)

# Development Machine installation

First, obtain the OpenCPU staging password (needed to access screensmart-r) by running this command:
`ssh -t 10.210.90.11 'sudo cat /var/www/screensmart.roqua-staging.nl/current/.env | grep OPENCPU_PASSWORD'`
Add a file .env.local, containing:
`OPENCPU_PASSWORD=<OPENCPU_PASSWORD found in above command>`

Then, as usual:
```bash
bundle
rails server
```

# Deployment
## Staging ([http://screensmart.herokuapp.com/](http://screensmart.herokuapp.com/))
Push to master and it will be automatically deployed when all checks pass.

## Own server (WIP)
In your projects directory:
```
git clone git@github.com:roqua/deployer.git
cd deployer
bin/screensmart-deploy staging
```
