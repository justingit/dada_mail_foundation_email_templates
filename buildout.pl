#!/usr/bin/perl 

use File::Copy; 
use File::Copy::Recursive;

my $distros = { 

	default => { 
		theme_file => 'theme-bak',
		target_dir => 'default',
	},
	car_camping => { 
		theme_file     => 'theme-car_camping',
		target_dir     => 'car_camping',
	},
	chocolate_love => { 
		theme_file     => 'theme-chocolate_love',
		target_dir     => 'chocolate_love',
	},
	dm_deep_red => { 
		theme_file     => 'theme-dm_deep_red',
		target_dir => 'dm_deep_red',
	},
	ocean_dream => { 
		theme_file => 'theme-ocean_dream',
		target_dir => 'ocean_dream',
	},
	
	

};


my $working_dir = './';
chdir($working_dir);


f_cp('theme.scss', 'theme-bak.scss');

foreach my $d(keys %$distros){ 

	my $theme_file = $distros->{$d}->{theme_file} . '.scss';
	my $target_dir = $distros->{$d}->{target_dir};
	
	f_cp( $theme_file, 'theme.scss');
	print `npm run noninteractive`;
	
	if(-d 'to_bundle/' . $target_dir){ 
		`rm -rf to_bundle/$target_dir`;
	}
	mkdir('to_bundle/' . $target_dir);

	f_dircopy('dist', 'to_bundle/' . $target_dir . '/dist'); 
	`rm theme.scss`;
}

f_cp('theme-bak.scss', 'theme.scss');

unlink('theme-bak.scss') or warn $!; 


sub f_cp {
    require File::Copy;
    my ( $to, $from ) = @_;
    my $r = File::Copy::copy( $to, $from );    # or croak "Copy failed: $!";
    return $r;
}


sub f_dircopy {
    my ( $source, $target ) = @_;
    File::Copy::Recursive::dircopy($source, $target )
      or die "can't copy directory from, '$source' to, '$target' because: $!";
}