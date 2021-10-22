# Limitless Minds Platform



## For Mac Users:
### Install Homebrew (brew.sh)
1. Check if homebrew is installed, type in Terminal: 
  ```
  $ which brew
  ```
2. Install Homebrew if not found
  ```
    $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

### Install Ruby
1. Check the version of Ruby you have installed by typing in Terminal:
  ```
  $ ruby -v
  ```
  - Installed version should be: ruby 2.7.4p191

2. Install Ruby if needed.
  ```
  $ brew install gnupg
  $ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E37D2BAF1CF37B13E2069D6956105BD0E739499BDB`
  $ \curl -sSL https://get.rvm.io | bash`
  ```
   QUIT TERMINAL
  ```
  $ rvm install 2.7.2
  ```

### Install Rails
1. Check the version of Rails
  ```
  $ rails -v
  ```
  - Installed version should be: 6.0.3.7
  
2. Install Rails if needed
  ```
  $ sudo gem install rails
  ```

### Install Postgresql
1. Check the version of postgres
  ```
  $ postgres -v
  ```
2. Install Postgres
  ```
  $ brew install postgresql@13.2
  ```
3. If you have mulitple versions switch to the correct version
  ```
  $ brew info postgresql
  $ brew switch postgresql 13.2 
  ```

### Make sure you have Git set up in your project folder:
  ```
  $ brew install git
  ```
  https://docs.github.com/en/github/getting-started-with-github/set-up-git

### Set up the project
1. Clone from Github to your code projects directory
  ```
  $ git clone https://github.com/mattnickel/guruapp
  ```
2. Change directories into new cloned directory
3. Bundle dependencies
  ```
  $ bundle install
  ```
4. Add JavaScript runtime - Nodejs
  ```
  brew install nodejs
  ```

### Add local config
1. Add secrets/video_images.json (ask for this file)
2. Add master.key (ask for this file)
3. Add sendgrid key as a local variable (ask for this key)
      https://sendgrid.com/docs/ui/account-and-settings/api-keys/

### Set up database
  ```
  $ brew services start postgresql
  ```
  Open up the psql termial
  ```
  $ psql postgres
  CREATE ROLE developer WITH LOGIN PASSWORD '123456';
  ALTER ROLE developer CREATEDB;
  ```
  Quit psql terminal
  ```
  \q
  ```  
  Log into psql with developer
  ```
  psql postgres -U developer
  ```
   
  TIP: Before migrating, comment out Training Modules Api logic (not sure why)
  ``` 
  $ rake db:migrate
  $ rake db:seed 
  ```
### Run rails project
    - Terminal: Rails s
    - brew install -g yarn
    - brew install node
    - rake webpacker:install
    - Go to browser: localhost:3000
    - Default Login: email: "test@test.com"   password: "123456"

## SETUP FOR WINDOWS ENVIRONMENT(WITH DOCKER)

### Docker Setup and installation
---
1. Install [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/)
   * Meet the necessary requirements prior to its installation
   * Refer to the installation documention.

    a)Enable the WSL 2 feature on Windows. 
    * [Download and install](https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package) the Linux kernel update package and Linux Subsystem(Ubuntu 20.04 LTS).
    
    b) [Enable Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v)

2. Install Windows Terminal and select the Ubuntu profile
3. Install git (if not yet installed)
  ```
  $ sudo apt-get install git
  ```
### Project Setup
---
1. Clone from Github to your code projects directory
  ```
  $ git clone https://github.com/mattnickel/guruapp
  ```
2. Add local config
  * Add secrets/video_images.json (ask for this file)
  * Add master.key (ask for this file)
  * Add sendgrid key as a local variable (ask for this key)

3. On the same level as the project directory create docker-compose.yml file with the following content: 
  ```
  version: "3.7"

  services:
    postgres:
      image: postgres
      ports:
        - 5432:5432
      environment:
        POSTGRES_PASSWORD: 123456
    ruby:
      image: ruby:2.7.4
      ports:
        - 3000:3000
      working_dir: /usr/src/app
      volumes:
        - ./lmd:/usr/src/app
    links: 
        - postgres
    tty: true
  ```
  Note: replace "lmd" with the project directory name and Generated ruby image should be ruby 2.7.4p191
  
4. On your Windows terminal run
  ```
  $ docker-compose up -d
  ```
  The necessary images will be generated in you docker

5. Goto the docker ruby CLI 
  a) install rails
  ```
  #gem install rails:6.0.3.7
  ```
  b) Install bundle dependencies
  ```
  #bundle install
  ```
  c) Run the following commands:
  ```
  #curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  #export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
  ```
  d) Install node
   ```
    #nvm install node
   ```
  e) Install npm
   ``` 
    #nvm install npm
   ```
  f) Install yarn
   ```
    #npm install -g yarn
   ```
6. On the Windows terminal check your postgres container ip address using
  ```
  $ docker container inspect dirName_postgres_1
  ```
  and set the ip address in your database.yml file located in config folder

### Postgres and Database Setup 
---
1. On the docker postgres CLI run the following
  ```
  #psql -U postgres
  #CREATE ROLE developer WITH LOGIN PASSWORD '123456';
  #ALTER ROLE developer CREATEDB;
  #CREATE DATABASE guruapp_dev1;
  #CREATE DATABASE guruapp_test;
  
  to exit from postgres prompt 
  #\q
  ```

### Rails Migration and Running the Rails App
---
1. Comment out logic in api/v1/training_modules
2. On the Docker ruby CLI run
  ```
  #rails db:migrate
  #rails db:seed
  ```
3. Uncomment/restore training modules logic
4. Run rails app with 
  ```
  #rails server -b=0.0.0.0
  ```
  Note: in some setups when closing the ruby cli 
  ```
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  ```
  needs to be entered again before entering the command to run the rails app
### Heroku 
---
  1. For Heroku Server install Heroku CLI
  ```
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
  
  or

  sudo snap install --classic heroku
  ```
 