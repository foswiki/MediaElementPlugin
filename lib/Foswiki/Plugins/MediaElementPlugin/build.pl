#!/usr/bin/env perl

BEGIN { unshift @INC, split(/:/, $ENV{FOSWIKI_LIBS}); }

use Foswiki::Contrib::Build;

use strict;
use warnings;

my $build = new Foswiki::Contrib::Build('MediaElementPlugin');

$build->build($build->{target});

