# Dist::Zilla::Plugin::Test::Version [![Build Status](https://secure.travis-ci.org/plicease/Dist-Zilla-Plugin-Test-Version.png)](http://travis-ci.org/plicease/Dist-Zilla-Plugin-Test-Version)

Author Test::Version tests

# SYNOPSIS

in `dist.ini`

    [Test::Version]
    is_strict   = 0
    has_version = 1

# DESCRIPTION

This module will add a [Test::Version](https://metacpan.org/pod/Test::Version) test as a author test to your module.

# ATTRIBUTES

## is\_strict

set [Test::Version is\_strict](https://metacpan.org/pod/Test::Version#is_strict)

## has\_version

set [Test::Version has\_version](https://metacpan.org/pod/Test::Version#has_version)

## filename\_match

set [Test::Version filename\_match](https://metacpan.org/pod/Test::Version#filename_match)

## multiple

set [Test::Version multiple](https://metacpan.org/pod/Test::Version#multiple)

## finder

This is the name of a [Dist::Zilla::Role::FileFinder](https://metacpan.org/pod/Dist::Zilla::Role::FileFinder) for finding files to check.
If this is specified then `version_ok` will be used for each file that matches,
otherwise `version_all_ok` will be used, and the file discovery will be handled
by [Test::Version](https://metacpan.org/pod/Test::Version).

# METHODS

## register\_prereqs

Register [Test::Version](https://metacpan.org/pod/Test::Version) as an a development prerequisite.

# BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/plicease/dist-zilla-plugin-test-version/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHORS

- Graham Ollis <plicease@cpan.org>
- Caleb Cushing <xenoterracide@gmail.com>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Caleb Cushing <xenoterracide@gmail.com>.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
