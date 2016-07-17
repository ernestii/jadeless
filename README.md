# Jadeless
This is my default starting point for rapid front-end web development.

This boilerplate uses 
* `less` css preprocessor
* `pug` (formerly `jade`) template engine
* `coffeescript`
* `bower` front-end package manager
* `grunt` for automatic building


## Using
### Before using
Make sure you have installed node.js and npm.

### Cloning
```
git clone https://github.com/ernestii/jadeless.git
cd jadeless
```

### Editing
Edit `package.json`, `Gruntfile.coffee`, `bower.json` to match your project name, version and dependencies.


### Installing dependencies
```
# install dependencies listed in package.json
npm install

# install dependencies listed in bower.json
$ bower install
```

### Building
```
# remove old build
$ rm -rf build

# build project
$ grunt
```

## Credits
I used sapphiriq's Gruntfile.coffee as starting point for this template
(https://gist.github.com/sapphiriq/4326419)