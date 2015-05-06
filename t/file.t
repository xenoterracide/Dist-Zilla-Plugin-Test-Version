use strict;
use warnings;
use Test::More;
use Test::DZil;
use Test::Script 1.05;
use Test::NoTabs;
use File::chdir;
use Path::Class qw( file );

my $tzil = Builder->from_config(
  {
    dist_root    => 'corpus/a',
  },
  {
    add_files => {
      'source/dist.ini' => simple_ini(
        {},
        ['GatherDir'],
        ['Test::Version']
      ),
      'source/lib/Foo/pm' => "package Foo;\nour \$VERSION = 1.00;\n1;\n",
    }
  },
);

$tzil->build;

my $fn = $tzil
  ->tempdir
  ->subdir('build')
  ->subdir('xt')
  ->subdir('release')
  ->file('test-version.t')
  ;

ok ( -e $fn, 'test file exists');

do {
  local $CWD = $tzil->tempdir->subdir('build')->stringify;
  #note "CWD = $CWD";
  notabs_ok      ( file(qw( xt release test-version.t ))->stringify, 'test has no tabs'    );
  script_compiles( file(qw( xt release test-version.t ))->stringify, 'check test compiles' );
  script_runs    ( file(qw( xt release test-version.t ))->stringify, 'check test runs'     );
};

done_testing;
