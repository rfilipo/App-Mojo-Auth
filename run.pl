#!/usr/bin/env perl
use Mojolicious::Lite;

use lib "lib";
use App::Mojo::Auth;
use 5.20.0;
use experimental 'signatures';

helper 'new_auth' => sub ($c, $db = "example/data/auth.sqlite") {
  my $auth = new App::Mojo::Auth;
  $auth->init(db => $db );
  return $auth;
};

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

get '/signup' => sub {
  my $c = shift;
  $c->render(template => 'signup');
};

post '/auth' => sub {
  my $c = shift;
  my $auth   = $c->new_auth();
  use Data::Dumper;
  print Dumper $c->param('username');
  print Dumper $c->param('password');
  $c->render(text => '123456789kkk');
};

under '/api';

any '/:action/:method/' => sub {
  my $c = shift;
  my $action = $c->stash('action');
  my $method = $c->stash('method');
  my $auth   = $c->new_auth;
  my $auth_key = $c->req->headers->to_hash->{'App-Mojo-Auth'};
 
  $c->res->headers->header( 'App-Mojo-Auth' => $auth );
  $c->render(text => '{'.$action.':'.$method.' }');
};

app->start;

__DATA__

@@ index.html.ep
% layout 'home';
% title 'Home';
<div id="page">
</div>
<!-- partial:index.partial.html -->
<div class="form">
  <div id="skull">
    <?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN"
 "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg version="1.0" xmlns="http://www.w3.org/2000/svg"
 width="1600.000000pt" height="1600.000000pt" viewBox="0 0 1600.000000 1600.000000"
 preserveAspectRatio="xMidYMid meet">
<g transform="translate(0.000000,1600.000000) scale(0.100000,-0.100000)"
fill="#000000" stroke="none">
<path d="M7467 14984 c-1842 -143 -3482 -974 -4437 -2249 -201 -269 -339 -494
-490 -800 -282 -572 -436 -1119 -516 -1825 -22 -196 -31 -781 -14 -978 74
-916 392 -2002 886 -3032 l98 -205 7 -315 c6 -290 8 -323 32 -420 100 -415
355 -753 732 -969 218 -125 429 -182 730 -196 213 -11 338 -67 417 -187 60
-91 73 -145 88 -378 12 -185 42 -327 101 -476 177 -444 545 -779 993 -904 187
-52 123 -50 1906 -50 1783 0 1719 -2 1906 50 439 123 804 449 983 880 73 174
99 304 120 595 11 145 28 205 79 283 47 71 120 125 212 155 61 20 110 27 260
36 283 17 436 54 657 161 276 134 487 346 624 625 65 133 99 230 130 374 19
83 22 138 26 416 l5 319 55 111 c272 540 563 1335 724 1970 167 664 226 1133
216 1733 -8 482 -46 790 -152 1212 -222 885 -658 1653 -1310 2305 -423 424
-892 760 -1465 1049 -814 412 -1681 648 -2625 716 -192 14 -773 10 -978 -6z
m993 -1010 c637 -56 1262 -212 1848 -463 609 -261 1158 -631 1577 -1063 623
-641 968 -1378 1081 -2308 25 -210 30 -684 10 -890 -68 -669 -296 -1495 -671
-2425 -93 -231 -224 -532 -275 -635 l-28 -55 -5 -370 c-4 -299 -8 -381 -21
-428 -46 -167 -143 -264 -306 -311 -30 -8 -134 -20 -231 -25 -282 -16 -443
-56 -664 -166 -152 -76 -238 -137 -355 -255 -118 -117 -179 -203 -255 -355
-107 -215 -150 -383 -166 -645 -13 -227 -45 -316 -150 -426 -65 -67 -123 -103
-214 -131 -57 -17 -135 -18 -1635 -18 -1500 0 -1578 1 -1635 18 -91 28 -149
64 -214 131 -105 110 -136 198 -151 428 -16 265 -58 428 -165 643 -76 152
-137 238 -255 355 -117 118 -203 180 -355 255 -219 108 -381 149 -644 165
-225 14 -316 46 -424 149 -68 65 -101 116 -130 204 -19 57 -21 93 -25 422 l-4
360 -28 55 c-48 96 -205 458 -288 665 -310 774 -521 1465 -617 2021 -39 228
-47 319 -52 585 -11 569 56 1037 222 1534 160 482 388 890 713 1280 174 207
487 499 722 672 792 582 1810 946 2890 1032 187 15 710 12 900 -5z"/>
<path d="M5250 8985 c-310 -51 -596 -201 -823 -431 -204 -207 -339 -459 -403
-754 -27 -122 -27 -477 0 -600 64 -293 200 -548 403 -752 296 -300 652 -448
1073 -448 421 0 778 149 1073 448 203 204 339 459 403 752 27 122 27 478 0
600 -66 301 -203 554 -414 764 -209 208 -466 348 -752 411 -105 23 -444 29
-560 10z"/>
<path d="M10250 8985 c-310 -51 -596 -201 -823 -431 -204 -207 -339 -459 -403
-754 -27 -122 -27 -477 0 -600 64 -293 200 -548 403 -752 296 -300 652 -448
1073 -448 421 0 778 149 1073 448 203 204 339 459 403 752 15 68 19 127 19
300 0 173 -4 232 -19 300 -66 301 -203 554 -414 764 -209 208 -466 348 -752
411 -105 23 -444 29 -560 10z"/>
<path d="M7909 5971 c-87 -44 -146 -88 -243 -181 -289 -278 -550 -740 -642
-1135 -14 -58 -19 -119 -19 -220 0 -135 1 -142 29 -194 39 -76 125 -162 199
-202 55 -30 72 -34 158 -37 266 -11 423 101 575 411 15 31 31 57 34 57 3 0 19
-26 34 -57 93 -191 185 -301 298 -357 89 -45 161 -59 277 -54 86 3 103 7 158
37 74 40 160 126 199 202 28 52 29 58 29 199 -1 158 -21 263 -85 437 -178 490
-558 988 -844 1107 -55 23 -93 20 -157 -13z"/>
</g>
</svg>
</div>
      <ul class="tab-group">
        <li class="tab active"><a href="#signup">sign up</a></li>
        <li class="tab"><a href="#login">log in</a></li>
      </ul>
      
      <div class="tab-content">
        <div id="signup">   
          <h1>take the risk!</h1>
          
          <form action="/" method="post">
          
          <div class="top-row">
            <div class="field-wrap">
              <label>
                first name<span class="req">*</span>
              </label>
              <input type="text" required autocomplete="off" />
            </div>
        
            <div class="field-wrap">
              <label>
                last name<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off"/>
            </div>
          </div>

          <div class="field-wrap">
            <label>
              email<span class="req">*</span>
            </label>
            <input type="email"required autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              password<span class="req">*</span>
            </label>
            <input type="password"required autocomplete="off"/>
          </div>
          
          <button type="submit" class="button button-block"/>register</button>
          
          </form>

        </div>
        
        <div id="login">   
          <h1>are you shure?</h1>
          
          <form action="/" method="post">
          
            <div class="field-wrap">
            <label>
              email<span class="req">*</span>
            </label>
            <input type="email"required autocomplete="off"/>
          </div>
          
          <div class="field-wrap">
            <label>
              password<span class="req">*</span>
            </label>
            <input type="password"required autocomplete="off"/>
          </div>
          
          <p class="forgot"><a href="#">forgot password?</a></p>
          
          <button class="button button-block"/>log In</button>
          
          </form>

        </div>
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->
<!-- partial -->
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script  src="js/main.js"></script>


@@ signup.html.ep
% layout 'default';
% title 'Home';
<div id="page">

</div>
<script src="/js/signup.js"></script>

@@ layouts/home.html.ep
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title><%= title %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="css/home.css">
</head>
<body>
<%= content %>
</body>
</html>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
