# pass insert

A [pass fork](https://github.com/HacKanCuBa/password-store) extension that provides a convenient solution to insert a file or password into the store, overriding native insert command.

If you are using [pass](https://passwordstore.org) from your distro package manager or from the [official repo](https://git.zx2c4.com/password-store), then this extension won't work. Use [pass insertfile](https://github.com/hackan/pass-extension-insertfile) instead.

## Usage

```
Usage:
    pass insert [--echo,-e | --multiline,-m] [--force,-f] pass-name [file-path]
        Insert new password. Optionally, echo the password back to the console
        during entry. Or, the entry may be multiline.
        If file-path is a file, it will be inserted (options for 
        echo and multiline are ignored)
        Prompt before overwriting existing password or file unless forced.

More information may be found in the pass-insert(1) man page.
```

See `man pass-insert` for more information.

## Example

Insert your ssh private key.

	pass insert Systems/General/SSHKey ~/.ssh/id_rsa

## Installation

### Linux

		git clone https://github.com/hackan/pass-extension-insert.git
		cd pass-extension-insert
		sudo make install

Or simply copy *insert.bash* to the pass extension directory (~/.password-store/.extensions by default).

#### Requirements

In order to use extension with `pass`, you need:
* `pass 1.7.0` or greater. As of today this version has not been released yet.
Therefore you need to install it by hand from the repo:

		git clone https://github.com/HacKanCuBa/password-store.git
		cd password-store
		sudo make install

* You need to enable the extensions in pass: `PASSWORD_STORE_ENABLE_EXTENSIONS=true pass`.
You can create an alias in `.bashrc`: `alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'`

## Contribution
Feedback, contributors, pull requests are all very welcome.

## License

    Copyright (C) 2017 HacKan (https://hackan.net)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

