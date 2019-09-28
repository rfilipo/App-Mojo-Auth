use strict;
use warnings;
package App::Mojo::Auth;

our $VERSION = '0.0.1';
use 5.20.0;
use experimental 'signatures';
use feature qw(say);
use Mojo::SQLite;
use Mojo::JWT;
use Mojo::JSON;
 
sub new {
    my ($class, %args) = @_;
    say "\n--------------\nApp::Mojo::Auth version $VERSION\n";
    $args{payload} = {id => 1, api_key => '19328436463vfufnjw8'};
    return bless \%args, $class;
}


sub init {
 my $self = shift;
 my (%args) = @_;
 $self->{sql} = Mojo::SQLite->new($args{db});
 say "SQLite initialized. Version: ".$self->{sql}->db->query('select sqlite_version() as version')->hash->{version}.' DB file: '.$args{db};
 say 'Users: '. $self->{sql}->db->query('SELECT COUNT(*) FROM users;')->text;
}

sub jwt_encode {
  my $self    = shift;
  my $payload = shift || $self->{payload}; 
  $self->{payload} = $payload;
  return Mojo::JWT->new(claims => $payload, secret => 's3cr3t')->encode;
}

sub jwt_decode {
  my $self = shift;
  my $jwt = shift;
  return Mojo::JWT->new(secret => 's3cr3t')->decode($jwt);
}

sub register {
 my ($self, %args) = @_;
 my $result;
 my $sql = "Insert into users (email, password) values('".
   $args{email}."', '".
   $args{password}."')";
use Data::Dumper;
 eval {
   $result = $self->{sql}->db->query($sql);
 };
 if ($@) {
   $result = { error => $@ };
 }
 return $result; 
}

sub login {
  my ($self, %args) = @_;
  my $email = $args{email};
  my $password = $args{password}; 
  my $payload = $self->{payload};

  # error
  unless($email eq 'test@test.com' && $password eq 'test') {
    return encode {error => 'invalid_username_or_password'};
  }

  return encode {api_token => $self->jwt_encode($payload)};
}

sub authenticate{
 my $self = shift;
 my $jwt  = shift;
 $jwt = $self->jwt_decode($jwt);
 return $jwt->{api_key} eq $self->{payload}->{api_key} ? 1 : 0;
}

sub authorize {
 my ($self, %args) = @_;

}

sub signup {
 my ($self, %args) = @_;

}

sub remove {
 my ($self, %args) = @_;
 my $result;
 my $sql = "DELETE FROM users WHERE id = $args{id};";
 eval {
   $result = $self->{sql}->db->query($sql);
 };
 if ($@) {
   $result = { error => $@ };
 }
 return $result; 
}


1;
__DATA__



__END__
