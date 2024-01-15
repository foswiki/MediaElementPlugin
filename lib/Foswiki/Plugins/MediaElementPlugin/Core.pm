# Foswiki - The Free and Open Source Wiki, http://foswiki.org/
# 
# Copyright (C) 2013-2024 Michael Daum http://michaeldaumconsulting.com
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version. For
# more details read LICENSE in the root of this distribution.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# 
# As per the GPL, removal of this notice is prohibited.

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
      version => '7.0.2',
      author => 'John Dyer',
      homepage => 'https://www.mediaelementjs.com',
      puburl => '%PUBURLPATH%/%SYSTEMWEB%/MediaElementPlugin/build',
      css => ['pkg.css'],
      javascript => ['pkg.js'],
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
  my $frame = $params->{frame} || 0;
  my $width = $params->{width};
  my $height = $params->{height};

  my $rotate = $params->{rotate};
  my $style = '';
  if ($rotate) {
    $style = "-moz-transform:rotate(${rotate}deg);-webkit-transform:rotate(${rotate}deg);-o-transform:rotate(${rotate}deg);-ms-transform:rotate(${rotate}deg);transform:rotate(${rotate}deg)";
  }


  my @videos = ();
  foreach my $file (split/\s*,\s*/, $video) {
    my $url;
    if ($file =~ /^https?:/i) {
      $url = $file
    } else {
      $url = Foswiki::Func::getPubUrlPath() . '/' . $web . '/' . $topic . '/' . $file;

      my $filePath = $Foswiki::cfg{PubDir} . '/' . $web . '/' . $topic . '/' . $file;
      unless (-f $filePath) {
        print STDERR "file not found: $filePath\n";
        next;
      }
    }

    push @videos, {
      web => $web,
      topic => $topic,
      file => $file,
      url => $url,
      mimeType => $mimeType || $this->getMimeType($file),
      poster => '%IMAGE{"'.$url.'" frame="'.$frame.'" output="png" '
        . ((defined $width && $width =~ /^\d+$/) ? 'width="'.$width.'" ':"")
        . ((defined $height && $height =~ /^\d+$/) ? 'height="'.$height.'"':'')
        . ' format="$src" crop="off" '
        . ($rotate ? 'rotate="' . $rotate . '"':'').' warn="off"}%',
    }
  }

  my $videos = join("\n", map {"<source type='$_->{mimeType}' src='$_->{url}'>"} @videos);

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
  $class="mejs-$skin" if $skin && $skin ne 'default';

  my $poster = $params->{poster} || '';
  if (!$autoplay && $poster !~ /^(none|off)$/) {
    if ($poster) {
      $poster = 'poster="'.$poster.'"';
    } else {
      $poster = 'poster="'.$videos[0]{poster}.'"' if defined $videos[0]{poster};
    }
  }

  my $stretch = $params->{stretch} || (defined $width || defined $height) ? 'none' : 'responsive';
  if ($stretch) {
    $stretch = "data-stretching='$stretch'";
  }

  my $id = $params->{id} || "mej-". (int( rand(10000) ) + 1);
  $width = (defined $width) ? "width='$width'": "";
  $height = (defined $height) ? "height='$height'": "";

  my $result = <<HERE;
<video id="$id" class="jqMediaElement $class" style="max-width:100%;$style" $width $height $poster $controls $autoplay $preload $stretch>
$videos
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
  $class="mejs-$skin" if $skin;

  my $url = '';
  unless ($url =~ /^https?:/i) {
    $url = Foswiki::Func::getPubUrlPath() . '/' . $web . '/' . $topic . '/' . $audio;
  }

  my $result = <<HERE;
<audio class="jqMediaElement $class" src="$url" $autoplay $preload></audio>
HERE

  return $result;
}

sub getMimeType {
  my ($this, $file) = @_;

  my $mimeType = 'video/mp4';

  if ($file && $file =~ /\.([^.]+)$/) {
    my $suffix = $1;
    
    unless ($this->{types}) {
      $this->{types} = Foswiki::Func::readFile($Foswiki::cfg{MimeTypesFileName});
    }

    if ($this->{types} =~ /^([^#]\S*).*?\s$suffix(?:\s|$)/im) {
      $mimeType = $1;
    }
  }

  return $mimeType;
}

1;
