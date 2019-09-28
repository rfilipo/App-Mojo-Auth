#!perl -T

use Test::More tests => 3;

BEGIN {
    use_ok( 'App::Mojo::Auth' ) || print "Bail out!
";
}

my $app = App::Mojo::Auth->new;

isa_ok ($app, 'App::Mojo::Auth');
can_ok ($app, new, init, jwt_encode, jwt_decode, register, authorize, authenticate, remove, signup);

diag( "Testing App::Mojo::Auth $App::Mojo::Auth::VERSION, Perl $], $^X" );
