package Dist::Zilla::Plugin::Test::Version;
use 5.006;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::TextTemplate';

around add_file => sub {
	my ( $orig, $self, $file ) = @_;

	$self->$orig(
		Dist::Zilla::File::InMemory->new({
			name    => $file->name,
			content => $self->fill_in_string(
				$file->content,
				{
					is_strict   => \$self->is_strict,
					has_version => \$self->has_version,
				},
			),
		})
	);
};

has is_strict => (
	is => 'ro',
	isa => 'Bool',
	lazy => 1,
	default => sub { 0 },
);

has has_version => (
	is => 'ro',
	isa => 'Bool',
	lazy => 1,
	default => sub { 1 },
);

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
    'Test::Version' => 1.002,
};

Test::Version->import(
	'version_all_ok',
	{
		is_strict   => {{ $is_strict }},
		has_version => {{ $has_version }},
	}
);

version_all_ok;
done_testing;
