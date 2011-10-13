#!perl

use Test::More;

use Devel::Cover::Report::Clover::Builder;
use Devel::Cover::Report::Clover::Project;
use FindBin;
use lib ($FindBin::Bin);
use testcover;
use Test::MockObject::Extends;

my $DB = testcover::run('multi_file');

my $b     = BUILDER( { name => 'test', db => $DB } );
my $p     = $b->project;
my @files = @{ $p->files };

my @test = (
    sub {
        my $t = "files - 3 of them";
        is( scalar @files, 3, $t );
    },
    sub {
        my $t = "loc";
        is( $p->loc(), 17, $t );
    },
    sub {
        my $t = "ncloc";
        is( $p->ncloc(), 28, $t );
    },
);

plan tests => scalar @test;

$_->() foreach @test;

sub BUILDER {
    return Devel::Cover::Report::Clover::Builder->new(shift);
}

