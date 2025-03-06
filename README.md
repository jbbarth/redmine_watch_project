Redmine watch_project plugin
======================

Allows to watch a project so that issues in this project are automatically marked as 'watched'

Installation
------------

This plugin is compatible with Redmine 2.1.0+.

Please apply general instructions for plugins [here](http://www.redmine.org/wiki/redmine/Plugins).

First download the source or clone the plugin and put it in the "plugins/" directory of your redmine instance. Note that this is crucial that the directory is named redmine_watch_project !

Then execute:

    $ bundle install
    $ rake redmine:plugins

And finally restart your Redmine instance.

Test status
-----------

|Plugin branch| Redmine Version | Test Status       |
|-------------|-----------------|-------------------|
|master       | 6.0.3           | [![6.0.3][1]][5]  |
|master       | 5.1.6           | [![5.1.6][2]][5]  |
|master       | master          | [![master][4]][5] |

[1]: https://github.com/jbbarth/redmine_watch_project/actions/workflows/6_0_3.yml/badge.svg
[2]: https://github.com/jbbarth/redmine_watch_project/actions/workflows/5_1_6.yml/badge.svg
[4]: https://github.com/jbbarth/redmine_watch_project/actions/workflows/master.yml/badge.svg
[5]: https://github.com/jbbarth/redmine_watch_project/actions

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
