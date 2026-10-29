# Wellcome ASCII

A simple bash program that prints a doodle each time you log in a shell. Configurable, with a toml file to select date ranges and a folder for storing doodles.

# Instalation

Git clone the project
```bash
git clone https://github.com/D1hn1/wellscii.git ~/.wellscii
```
Chmod script
```bash
chmod +x ~/.wellscii/wellscii.sh
```
Modify .bashrc (add to the end of the file).
```sh
source ~/.wellscii/wellscii.sh
```

# Ussage

Create your doodles on the dooles/ folder.
```sh
$ echo ":)" > doodle.txt
$ ls doodles/
default.txt example.txt doodle.txt
```
Modify the wellscii.toml file
```toml
# The name of the file without .txt.
[doodle]

# The date from and to it is going to be printed.
from="01/01"
to="01/02"

# Let the default one be the last one.
[default]

from="*"
to="*"
```
