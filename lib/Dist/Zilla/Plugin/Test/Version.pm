package Dist::Zilla::Plugin::Test::Version;
use 5.006;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with qw(
	Dist::Zilla::Role::TextTemplate
	Dist::Zilla::Role::PrereqSource
);

around add_file => sub {
	my ( $orig, $self, $file ) = @_;

	$self->$orig(
		Dist::Zilla::File::InMemory->new({
			name    => $file->name,
			content => $self->fill_in_string(
				$file->content,
				{
					name        => __PACKAGE__,
					version     => __PACKAGE__->VERSION
						|| 'bootstrapped version'
						,
					is_strict   => \$self->is_strict,
					has_version => \$self->has_version,
				},
			),
		})
	);
};

sub register_prereqs {
	my $self = shift;
	$self->zilla->register_prereqs({
			type  => 'requires',
			phase => 'develop',
		},
		'Test::More'    => 0,
		'Test::Version' => 1,
	);
	return;
}

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

=head1 SYNOPSIS

in C<dist.ini>

	[Test::Version]
	is_strict   = 0
	has_version = 1

=head1 DESCRIPTION

This module will add a L<Test::Version> test as a release test to your module.

=attr is_strict

set L<Test::Version is_strict|Test::Version/is_strict>

=attr has_version

set L<Test::Version has_version|Test::Version/has_version>

=method register_prereqs

Register L<Test::Version> as an a development prerequisite.

=cut

__DATA__
__[ xt/release/test-version.t ]__
use strict;
use warnings;
use Test::More;

# generated by {{ $name }} {{ $version }}
use Test::Version;

my @imports = ( 'version_all_ok' );

my $params = {
    is_strict   => {{ $is_strict }},
    has_version => {{ $has_version }},
};

push @imports, $params
    if version->parse( $Test::Version::VERSION ) >= version->parse('1.002');


Test::Version->import(@imports);

version_all_ok;
done_testing;
