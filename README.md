# passh insert

A [passh](https://github.com/HacKanCuBa/passh) extension that provides a convenient solution to insert a file or password into the store, overriding native insert command.

If you are using [pass](https://passwordstore.org) - instead of the fork passh - from your distro package manager or from the [official repo](https://git.zx2c4.com/password-store), then this extension won't work. Use [pass insertfile](https://github.com/hackan/pass-extension-insertfile) instead.

## Usage

```
Usage:
    passh insert [--echo,-e | --multiline,-m] [--force,-f] pass-name [file-path]
        Insert new password. Optionally, echo the password back to the console
        during entry. Or, the entry may be multiline.
        If file-path is a file, it will be inserted (options for 
        echo and multiline are ignored)
        Prompt before overwriting existing password or file unless forced.

More information may be found in the passh-insert(1) man page.
```

See `man passh-insert` for more information.

## Example

Insert your ssh private key.

	passh insert Systems/General/SSHKey ~/.ssh/id_rsa

## Installation

Check the [releases](https://github.com/HacKanCuBa/passh-extension-insert/releases) to use a tested signed version of this extension. If you want the bleeding edge version, keep reading.

### Linux

		git clone https://github.com/hackan/passh-extension-insert.git
		cd passh-extension-insert
		sudo make install

Or simply copy *insert.bash* to the pass extension directory (~/.password-store/.extensions by default) and set it executable to enable it: `chmod +x insert.bash`.

#### Requirements

In order to use extension with `passh`, you need:

* `passh 1.7.0` or greater. Check the [website](https://passh.hackan.net) on how to obtain it.  
* You need to enable the extensions in passh: `PASSWORD_STORE_ENABLE_EXTENSIONS=true passh`.  
You can create an alias in `.bashrc`: `alias passh='PASSWORD_STORE_ENABLE_EXTENSIONS=true passh'`

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

