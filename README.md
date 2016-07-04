[![Circle CI](https://circleci.com/gh/roqua/screensmart.svg?style=svg)](https://circleci.com/gh/roqua/screensmart)
[![Issue Count](https://codeclimate.com/github/roqua/screensmart/badges/issue_count.svg)](https://codeclimate.com/github/roqua/screensmart)

# Development Machine installation
First, obtain the OpenCPU staging password (needed to access screensmart-r) by running this command:
ssh -qt stag-screensmart-web1 'sudo cat /var/www/screensmart.roqua-staging.nl/current/.env | grep OPENCPU_PASSWORD'
Add a file .env.local, containing the output of the last command:
```sh
# .env.local
OPENCPU_PASSWORD=<OPENCPU_PASSWORD found in above command>`
```

Then, as usual:
```sh
bundle
rails server
```

# Deployment
```sh
git clone git@github.com:roqua/deployer.git
cd deployer
bin/app-release screensmart staging
bin/app-deploy screensmart staging
bin/app-release screensmart production
bin/app-deploy screensmart production
```

# Development
## When a new screensmart-r version is released
When a new screensmart-r version is released which changes the API / schema,
screensmart needs to be adapted to match this schema.
[https://github.com/roqua/screensmart/blob/master/spec/support/mock_all_calls_to_r.rb#L1](`spec/support/mock_all_calls_to_r.rb` contains instructions and helpers to do this)

## Architecture
```
                               +---------+       +--------+
- Storage backend              |         |       |        |
- Has no knowledge of schema   |  RoQua  |       |  Core  | - Proxy for invitation e-mails
                               |         |       |        |
                               +----^----+       +----^---+
                                    |                 |
                                    |                 |
                                    |                 |
                                    |                 |
                                    |                 |
                                    |                 |
                                    |                 |
                                    |                 |
                                    |                 |
                                   +---------------------+          +-----------+
- Authorizes browser requests      |                     <----------+           |  - User Interface
- Makes authenticated API requests |      screensmart    |          |  Browser  |  -
                                   |                     +---------->           |
                                   +-------------^-------+          +-----------+
                                          |      |
                                          |      |
                                          |      |
                                          |      |
                                          |      |
                                          |      |
                                          |      |
                                 +--------v-----------------+
                                 |         OpenCPU          |
                                 |                          |
                                 | +---------------------+  | - determines next question based on answer
                                 | |                     |  | - source of questions & domains
                                 | |    screensmart-r    |  |
                                 | |                     |  |
                                 | +---------------------+  |
                                 +--------------------------+
```
