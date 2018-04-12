# perl-simple-yubi-auth
Simple set of scripts that demonstrate how to protect a Perl / Dancer2 application with a YubiKey.  

## Getting Started

You need to edit:

```
lib/Simple/YubiAuth.pm
```

You will need to add lines of the format:

```
'dddddddddddd' => '12321:0oHCE7ekdmdsaewDD312DDASWHU=:Fred Blogs',
```

For each yubi key.

You can start the application with something like:

```
plackup -R . bin/app.psgi
```

## Bugs

Please feel free to report any ....

## Requirements
You will of course need to install Dancer2 and have an understanding of it.

You will need to install the yubico perl client - and that can be found here:

* [yubico-perl-client](https://github.com/Yubico/yubico-perl-client) - yubico-perl-client

Get a API key for your YubiKey from:

* [getapikey](https://upgrade.yubico.com/getapikey) - API key


## To Do
Make this into a controller plugin for Dancer



