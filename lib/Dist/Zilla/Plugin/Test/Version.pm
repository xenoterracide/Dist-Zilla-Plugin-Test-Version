package Dist::Zilla::Plugin::Test::Version;
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

=head2 SYNOPSIS

in C<dist.ini>

	[Test::Version]

=head2 DESCRIPTION

This module will add a L<Test::Version> test as a release test to your module.

=cut

__DATA__
__[ xt/release/test-version.t ]__
#!/usr/bin/perl
use 5.006;
use strict;
use warnings;
use Test::More;

use Test::Requires {
    'Test::Version' => 0.04,
};

version_all_ok;
done_testing;
