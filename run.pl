#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

post '/auth' => sub {
  my $c = shift;
  use Data::Dumper;
  #print Dumper $c;
  $c->render(text => '123456789kkk');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Home';
<div id="page"></div>
<script src="/js/auth.js"></script>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
