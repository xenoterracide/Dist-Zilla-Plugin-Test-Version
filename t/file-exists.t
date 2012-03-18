use strict;
use warnings;
use Test::More;
use Test::DZil;

my $tzil
	= Builder->from_config(
		{
			dist_root    => 'corpus/a',
			tempdir_root => '.build',
		},
		{
			add_files => {
				'source/dist.ini' => simple_ini(['Test::Version'])
			}
		},
	);

$tzil->build;

my $release_dir
	= $tzil
	->tempdir
	->subdir('build')
	->subdir('xt')
	->subdir('release')
	;

ok ( -e $release_dir . '/test-version.t', 'test file exists');

done_testing;
