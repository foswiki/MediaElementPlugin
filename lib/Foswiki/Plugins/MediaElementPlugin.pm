# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# MediaElementPlugin is Copyright (C) 2013-2024 Michael Daum http://michaeldaumconsulting.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details, published at
# http://www.gnu.org/copyleft/gpl.html

package Foswiki::Plugins::MediaElementPlugin;

use strict;
use warnings;
use Foswiki::Plugins::JQueryPlugin ();

our $VERSION = '3.21';
our $RELEASE = '%$RELEASE%';
our $SHORTDESCRIPTION = "Cross-browser embedding of videos and audios";
our $LICENSECODE = '%$LICENSECODE%';
our $NO_PREFS_IN_TOPIC = 1;

sub initPlugin {

  Foswiki::Plugins::JQueryPlugin::registerPlugin("MediaElement", "Foswiki::Plugins::MediaElementPlugin::Core");

  Foswiki::Func::registerTagHandler('VIDEO', sub {
    my $plugin = Foswiki::Plugins::JQueryPlugin::createPlugin('MediaElement');

    return $plugin->handleVIDEO(@_) if $plugin;
    return '';
  });

  Foswiki::Func::registerTagHandler('AUDIO', sub {
    my $plugin = Foswiki::Plugins::JQueryPlugin::createPlugin('MediaElement');

    return $plugin->handleAUDIO(@_) if $plugin;
    return '';
  });

  return 1;
}

1;

