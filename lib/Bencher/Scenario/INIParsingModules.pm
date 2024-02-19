package Bencher::Scenario::INIParsingModules;

use 5.010001;
use strict;
use warnings;

use File::ShareDir::Tarball qw(dist_dir);

# AUTHORITY
# DATE
# DIST
# VERSION

our $scenario = {
    summary => 'Benchmark INI parsing modules',
    modules => {
        # minimum versions
        #'Foo' => {version=>'0.31'},
    },
    participants => [
        {
            module => 'Config::IOD::INI::Reader',
            code_template => 'state $iod = Config::IOD::INI::Reader->new; $iod->read_file(<filename>)',
        },
        {
            module => 'Config::INI::Reader',
            code_template => 'Config::INI::Reader->read_file(<filename>)',
        },
        {
            module => 'Config::IniFiles',
            code_template => 'Config::IniFiles->new(-file => <filename>)',
        },
        {
            module => 'Config::Simple::Conf',
            code_template => 'Config::Simple::Conf->new(<filename>)',
        },
        {
            module => 'Config::INI::Tiny',
            code_template => 'state $cfg = Config::INI::Tiny->new; $cfg->to_hash(do { local $/; open my $fh, "<", <filename> or die; scalar readline($fh) } )',
        },
        {
            module => 'Config::Tiny',
            code_template => 'Config::Tiny->read(<filename>)',
        },
    ],

    datasets => [
    ],
};

my $dir = dist_dir('INI-Examples')
    or die "Can't find share dir for INI-Examples";
for my $filename (glob "$dir/examples/*bench*.ini") {
    my $basename = $filename; $basename =~ s!.+/!!;
    push @{ $scenario->{datasets} }, {
        name => $basename,
        args => {filename => $filename},
    };
}

1;
# ABSTRACT:
