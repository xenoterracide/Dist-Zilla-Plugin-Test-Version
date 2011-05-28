package Dist::Zilla::Plugin::VersionTests;
use 5.006;
use strict;
use warnings;
BEGIN {
	# VERSION
}
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';

__PACKAGE__->meta->make_immutable;
1;

# ABSTRACT: release Test::Version tests

__DATA__
__[ xt/release/test-version.t ]__
#!/usr/bin/perl
use 5.006;
use strict;
use warnings;

eval "use Test::Version";
plan skip_all => "Test::Version required for testing versions"
	if $@;

version_all_ok;
