# dokku-redirects-plugin

[![Build Status](https://travis-ci.org/Mordred/dokku-redirects-plugin.png?branch=master)](https://travis-ci.org/Mordred/dokku-redirects-plugin)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/Mordred/dokku-redirects-plugin/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

[Dokku](https://github.com/progrium/dokku) plugin to create nginx vhost which redirects domains to primary domain.

## Installation

```bash
git clone https://github.com/mordred/dokku-redirects-plugin.git /var/lib/dokku/plugins/redirects-plugin
dokku plugins-install
```

## Commands

```bash
$ dokku help
    redirects <app>                                                   display redirects for an app
    redirects:set <app> DOMAIN1=DOMAIN2 [DOMAIN3=DOMAIN4 ...]         set one or more domains redirects
```

## Simple usage

Your need to have app running with the same name!

Create vhost with multiple where one domain redirects all request to another 

```bash
$ dokku redirects:set myawesomeapp.com=www.myawesomeapp.com            # Server side
$ ssh dokku@server redirects:set myawesomeapp.com=www.myawesomeapp.com # Client side
```

## License
MIT
