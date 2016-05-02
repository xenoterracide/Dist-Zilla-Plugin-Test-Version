use strict;
use warnings;
use Test::More;
use Test::DZil;
use Path::Class qw( dir );

subtest normal => sub {

  my $tzil = Builder->from_config(
    {
      dist_root    => 'corpus/a',
    },
    {
      add_files => {
        'source/dist.ini' => simple_ini(
          { version => '1.00' },
          ['GatherDir'],
          ['Test::Version', { is_strict => 'adaptive' } ]
        ),
        'source/lib/Foo.pm' => "package Foo;\nour \$VERSION = 1.00;\n1;\n",
      }
    },
  );

  $tzil->build;

  my($plugin) = grep { $_->isa('Dist::Zilla::Plugin::Test::Version') } @{ $tzil->plugins };

  ok $plugin->_is_strict, "\$plugin->_is_strict = @{[ $plugin->_is_strict ]}";

  my $fn = dir($tzil->tempdir)
    ->subdir('build')
    ->subdir('xt')
    ->subdir('author')
    ->file('test-version.t')
    ;

  ok ( -e $fn, 'test file exists');

  note $fn->slurp;

};

subtest abbynormal => sub {

  my $tzil = Builder->from_config(
    {
      dist_root    => 'corpus/a',
    },
    {
      add_files => {
        'source/dist.ini' => simple_ini(
          { version => '1.00_01' },
          ['GatherDir'],
          ['Test::Version', { is_strict => 'adaptive' } ]
        ),
        'source/lib/Foo.pm' => "package Foo;\nour \$VERSION = 1.00_01;\n1;\n",
      }
    },
  );

  $tzil->build;

  my($plugin) = grep { $_->isa('Dist::Zilla::Plugin::Test::Version') } @{ $tzil->plugins };

  ok !$plugin->_is_strict, "\$plugin->_is_strict = @{[ $plugin->_is_strict ]}";

  my $fn = dir($tzil->tempdir)
    ->subdir('build')
    ->subdir('xt')
    ->subdir('author')
    ->file('test-version.t')
    ;

  ok ( -e $fn, 'test file exists');

  note $fn->slurp;

};

done_testing;
