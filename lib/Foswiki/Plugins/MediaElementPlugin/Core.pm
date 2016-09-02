# See bottom of file for license and copyright information

package Foswiki::Plugins::MediaElementPlugin::Core;
use strict;
use warnings;

use Foswiki::Plugins::JQueryPlugin::Plugin ();
our @ISA = qw( Foswiki::Plugins::JQueryPlugin::Plugin );

=begin TML

---+ package Foswiki::Plugins::MediaElementPlugin::Core

This is the perl stub for the jquery mediaelement plugin.

=cut

=begin TML

---++ ClassMethod new( $class, $session, ... )

Constructor

=cut

sub new {
  my $class = shift;
  my $session = shift || $Foswiki::Plugins::SESSION;

  my $this = bless(
    $class->SUPER::new(
      $session,
      name => 'MediaElement',
      version => '2.22.1',
      author => 'John Dyer',
      homepage => 'http://mediaelementjs.com',
      css => ['pkg.css'],
      javascript => ['pkg.js'],
      puburl => '%PUBURLPATH%/%SYSTEMWEB%/MediaElementPlugin',
      dependencies => ["livequery"],
    ),
    $class
  );

  return $this;
}

sub handleVIDEO {
  my ($this, $session, $params, $topic, $web) = @_;

  my $video = $params->{_DEFAULT} || '';

  $topic = $params->{topic} || $topic;
  ($web, $topic) = Foswiki::Func::normalizeWebTopicName($web, $topic);

  my $mimeType = $params->{mime};

  my @videos = ();
  foreach my $file (split/\s*,\s*/, $video) {
    my $url;
    if ($file =~ /^https?:/i) {
      $url = $file
    } else {
      $url = Foswiki::Func::getPubUrlPath() . '/' . $web . '/' . $topic . '/' . $file;
    }

    push @videos, {
      web => $web,
      topic => $topic,
      file => $file,
      url => $url,
      mimeType => $mimeType || $this->getMimeType($file),
    }
  }

  my $videos = join("\n", map {"<source type='$_->{mimeType}' src='$_->{url}'>"} @videos);

  my $width = $params->{width} || 320;
  my $height = $params->{height} || '240';

  my $controls = "";
  my $controlsBool = "false";
  if (Foswiki::Func::isTrue($params->{controls}, 1)) {
    $controls = 'controls';
    $controlsBool = 'true';
  }

  my $preload = Foswiki::Func::isTrue($params->{preload}, 0) ? '':'preload="none"';
  my $autoplay = Foswiki::Func::isTrue($params->{autoplay}, 0) ? 'autoplay':'';

  my $skin = $params->{skin} || '';
  my $class = '';
  $class="class='mejs-$skin" if $skin && $skin ne 'default';


  my $rotate = $params->{rotate};
  my $style = '';
  if ($rotate) {
    $style = "style='-moz-transform:rotate(${rotate}deg);-webkit-transform:rotate(${rotate}deg);-o-transform:rotate(${rotate}deg);-ms-transform:rotate(${rotate}deg);transform:rotate(${rotate}deg);'";
  }

  my $frame = $params->{frame} || 0;
  my $poster = $params->{poster} || '';
  my $placeholder = '%MAKETEXT{"No video playback capabilities}%';
  if (!$autoplay && $poster !~ /^(none|off)$/) {
    if ($poster) {
      $poster = 'poster="'.$poster.'"';
    } else {
      $poster = 'poster="%IMAGE{"'.$videos[0]{url}.'" frame="'.$frame.'" output="png" width="'.$width.'" '.($height ne 'auto'?'height="'.$height.'"':'').' format="$src" crop="on" '.($rotate?'rotate="'.$rotate.'"':'').'}%"';
      $placeholder = '%IMAGE{"'.$videos[0]{url}.'" frame="'.$frame.'" output="png" width="'.$width.'" '.($height ne 'auto'?'height="'.$height.'"':'').' title="'.$placeholder.'" type="plain" crop="on"}%';
    }
  }

  my $id = $params->{id} || "mej-". (int( rand(10000) ) + 1);

  my $result = <<HERE;
<video id="$id" $class $style width="$width" height="$height" $poster $controls $autoplay $preload>
    $videos
    <object width="$width" height="$height" type="application/x-shockwave-flash" data="%PUBURLPATH%/%SYSTEMWEB%/MediaElementPlugin/flashmediaelement.swf">
        <param name="movie" value="%PUBURLPATH%/%SYSTEMWEB%/MediaElementPlugin/flashmediaelement.swf" />
        <param name="flashvars" value="controls=$controlsBool&file=$videos[0]{url}" />
        $placeholder;
    </object>
</video>
HERE


  return $result;
}

sub handleAUDIO {
  my ($this, $session, $params, $topic, $web) = @_;

  my $audio = $params->{_DEFAULT} || '';

  $topic = $params->{topic} || $topic;
  ($web, $topic) = Foswiki::Func::normalizeWebTopicName($web, $topic);

  my $preload = Foswiki::Func::isTrue($params->{preload}, 0) ? '':'preload="none"';
  my $autoplay = Foswiki::Func::isTrue($params->{autoplay}, 0) ? 'autoplay="autoplay"':'';
  my $skin = $params->{skin} || '';

  my $class = '';
  $class="class='mejs-$skin" if $skin;

  my $url = '';
  unless ($url =~ /^https?:/i) {
    $url = Foswiki::Func::getPubUrlPath() . '/' . $web . '/' . $topic . '/' . $audio;
  }

  my $result = <<HERE;
<audio $class src="$url" $autoplay $preload></audio>
HERE

  return $result;
}

sub getMimeType {
  my ($this, $file) = @_;

  my $mimeType = 'video/mp4';

  if ($file && $file =~ /\.([^.]+)$/) {
    my $suffix = $1;
    
    unless ($this->{types}) {
      $this->{types} = Foswiki::readFile($Foswiki::cfg{MimeTypesFileName});
    }

    if ($this->{types} =~ /^([^#]\S*).*?\s$suffix(?:\s|$)/im) {
      $mimeType = $1;
    }
  }

  return $mimeType;
}

1;

__END__
Foswiki - The Free and Open Source Wiki, http://foswiki.org/

Copyright (C) 2013-2016 Michael Daum http://michaeldaumconsulting.com

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version. For
more details read LICENSE in the root of this distribution.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

As per the GPL, removal of this notice is prohibited.


