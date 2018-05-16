Zinc API Docs
-------------

Public API documentation for the Zinc API.


Deploying
====


### 1. Install prerequisites (first time only) ###

```
$> sudo apt-get install ruby ruby-dev
## Add gem to path by adding the following lines to .bashrc
export GEM_HOME=$HOME/.gems
export PATH=$PATH:$GEM_HOME/bin

$> gem install bundle
$> bundle install
```

### 2. Publish to docs.zincapi.com (every time you update docs) ###

````
$> rake publish
````
