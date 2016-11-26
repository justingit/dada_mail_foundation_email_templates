#!/usr/bin/perl 

use File::Copy; 
use File::Copy::Recursive;

my $distros = { 

	default => { 
		assets => 'assets-bak',
		target_dir => 'default',
	},
	ddm_red => { 
		assets     => 'assets-ddm_red',
		target_dir => 'ddm_red',
	},
};


my $working_dir = './';
chdir($working_dir);


f_dircopy('src/assets', 'src/assets-bak');

foreach my $d(keys %$distros){ 
	my $assets_dir = $distros->{$d}->{assets};
	my $target_dir = $distros->{$d}->{target_dir};
	
	f_dircopy( 'src/' . $assets_dir, 'src/assets');
	print `npm run noninteractive`;
	
	if(-d 'to_bundle/' . $target_dir){ 
		`rm -rf to_bundle/$target_dir`;
	}
	
	mkdir('to_bundle/' . $target_dir);
	f_dircopy('dist', 'to_bundle/' . $target_dir . '/dist'); 
	`rm -rf src/assets`;
}

f_dircopy('src/assets-bak', 'src/assets'); 

`rm -rf src/assets-bak`;



sub f_dircopy {
    my ( $source, $target ) = @_;
    File::Copy::Recursive::dircopy($source, $target )
      or die "can't copy directory from, '$source' to, '$target' because: $!";
}