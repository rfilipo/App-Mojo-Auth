#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'App::Mojo::Auth' ) || print "Bail out!
";
}

my $email = 'test@test.com';
my $password = 'blah';

my $app = App::Mojo::Auth->new;
$app->init(db => 'example/data/auth.sqlite');
my $result = $app->register(email => $email, password => $password );
if ($result->{error}) { 
  if ($result->{error} =~ /UNIQUE constraint/) { 
    print "ERROR: User exists in database\n"; 
  } else {
    print $result->{error};
  }
  ok($result->{error}, "Error inserting user");
} else {
  ok($result->last_insert_id > 0, 'Inserted records' );
  # remove it
  my $id = $result->last_insert_id;
  $app->remove(id => $id);
}


