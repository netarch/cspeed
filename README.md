# About

_cSpeed.net_ Website built using [Jekyll](https://jekyllrb.com) and [Jasper](https://github.com/biomadeira/jasper).


## Installing dependencies

First install `bundler` and `jekyll`. If you do not have administrator privileges on the machine, use the option `--user-install` as shown below to install the gems in the user's home directory.
```
§ gem install --user-install bundler jekyll
```

The commands in this section assume that you are using `bash` or `zsh`. If you are using a different shell, you may have to alter the commands for your shell.

Define `GEM_HOME` variable in the current session, or optionally copy the setting to your shell's initialization file.
```
§ export GEM_HOME="$HOME/.gem"
```

Add the gem binaries to `PATH`.
```
# If you are running `ruby` version `2.3.x`,
#  the value `2.3.0` in the command below will work fine.
§ export PATH="$GEM_HOME//ruby/2.3.0/bin"
```

Install all the gem dependencies as follows.
```
# Navigate to the Website directory.
# § cd .../path/to/cspeed.net
§ bundle install
```

On MacOS 12.3 or above, you might have to use the following fix to install `rdiscount`.
```
§ bundle config build.rdiscount --with-cflags=-Wno-error=implicit-function-declaration
§ bundle install
```


## Building the site

Run the shell script `build-site.sh` from the Website's root directory.
```
§ ./build-site.sh
```


## Deploying the site

Copy contents of `_site` to target location.
