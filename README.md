# Limitless Minds Platform



## For Mac Users:
### Install Homebrew (brew.sh)
1. Check if homebrew is installed
   * Terminal: which brew
2. Install Homebrew if not found
    - Terminal: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### Install Ruby
1. Check the version of Ruby you have installed by typing:
   - Terminal: ruby -v
   - Installed version should be: ruby 2.7.2p137

2. Install Ruby if needed.
    $ brew install gnupg
    $ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    $ \curl -sSL https://get.rvm.io | bash
    QUIT TERMIMAL
    $ rvm install 2.7.2

### Install Rails
1. Check the version of Rails
    - Terminal: rails -v
    - Installed version should be: 6.0.3.4
  
2. Install Rails if needed
    - Terminal: sudo gem install rails

### Install Postgresql
1. Check the version of postgres
    - Terminal: postgres -v
2. Install Postgres
    - Terminal: brew install postgresql@13.2
3. If you have mulitpe versions switch to the correct version
    - brew info postgresql
    - Terminal: brew switch postgresql 13.2 

### Make sure you have Git set up in your project folder:
    https://docs.github.com/en/github/getting-started-with-github/set-up-git

### Fork the project
1. Clone from Github
    - Terminal: git clone https://github.com/mattnickel/guruapp
2. Change directories into new cloned directory

### Add local config
1. Add secrets/video_images.json (ask for this file)
2. Add master.key (ask for this file)
3. Add sendgrid key as a local variable (ask for this key)
      https://sendgrid.com/docs/ui/account-and-settings/api-keys/

### Set up database
    - Terminal: rake db:migrate
    - Terminal: rake db:seed

### Run rails project
    - Terminal: Rails s
    - Go to browser: localhost:3000
    - Default Login: email: "test@test.com"   password: "123456"
