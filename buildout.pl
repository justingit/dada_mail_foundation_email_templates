#!/usr/bin/perl 

use File::Copy; 
use File::Copy::Recursive;

my $scss_dir    = 'src/assets/scss'; 
my $working_dir = './';


=pod
	pacifico => { 
		theme_file     => 'theme-pacifico',
		target_dir     => 'pacifico',
	
	}, 
=cut


my $distros = { 

	default => { 
		theme_file => 'theme-bak',
		target_dir => 'default',
	},

bird_of_paradise => { 
	theme_file     => 'theme-bird_of_paradise',
	target_dir     => 'bird_of_paradise',
},

car_camping => { 
	theme_file     => 'theme-car_camping',
	target_dir     => 'car_camping',
},

chocolate_love => { 
	theme_file     => 'theme-chocolate_love',
	target_dir     => 'chocolate_love',
},

digging_in_the_dirt => { 
	theme_file     => 'theme-digging_in_the_dirt',
	target_dir => 'digging_in_the_dirt',

},

dm_deep_red => { 
	theme_file     => 'theme-dm_deep_red',
	target_dir => 'dm_deep_red',
},

flamingo_park => { 
	theme_file     => 'theme-flamingo_park',
	target_dir     => 'flamingo_park',
},

holiday_hello_candy_cane => { 
	theme_file     => 'theme-holiday_hello_candy_cane',
	target_dir     => 'holiday_hello_candy_cane',
},

minty_fresh => { 
	theme_file     => 'theme-minty_fresh',
	target_dir     => 'minty_fresh',
},
	
nonviolent_violet => { 
	theme_file     => 'theme-nonviolent_violet',
	target_dir     => 'nonviolent_violet',
},

ocean_dream => { 
	theme_file => 'theme-ocean_dream',
	target_dir => 'ocean_dream',
},

plain_white_t => {
	theme_file => 'theme-plain_white_t',
	target_dir => 'plain_white_t',
},

salmon_are_running => { 
	theme_file     => 'theme-salmon_are_running',
	target_dir     => 'salmon_are_running',
},

summer_is_coming => { 
	theme_file     => 'theme-summer_is_coming',
	target_dir     => 'summer_is_coming',
},

techwear_in_the_alps => { 
	theme_file     => 'theme-techwear_in_the_alps',
	target_dir     => 'techwear_in_the_alps',
},

}; 

chdir($working_dir);


f_cp(
	$scss_dir . '/theme.scss', 
	$scss_dir . '/theme-bak.scss'
);

foreach my $d(keys %$distros){ 
	
	my $theme_file = $distros->{$d}->{theme_file} . '.scss';
	my $target_dir = $distros->{$d}->{target_dir};
	
	print '$theme_file: ' . $theme_file . "\n";
	print '$target_dir: ' . $target_dir . "\n";
	
	f_cp( 
		$scss_dir . '/' . $theme_file, 
		$scss_dir . '/' . 'theme.scss'
	);
	
	print `npm run noninteractive`;
	
	if(-d 'to_bundle/' . $target_dir){ 
		`rm -rf to_bundle/$target_dir`;
	}
	mkdir('to_bundle/' . $target_dir);

	f_dircopy(
		'dist', 
		'to_bundle/' . $target_dir . '/dist'
	); 
	
	unlink($scss_dir . '/' . 'theme.scss');
}

f_cp(
	$scss_dir . '/theme-bak.scss', 
	$scss_dir . '/theme.scss'
);

unlink($scss_dir . '/theme-bak.scss') 
	or warn $!; 


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