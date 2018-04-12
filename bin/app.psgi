#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use Simple::YubiAuth;

Simple::YubiAuth->to_app;

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use Simple::YubiAuth;
use Plack::Builder;

builder {
    enable 'Deflater';
    Simple::YubiAuth->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use Simple::YubiAuth;
use Simple::YubiAuth_admin;

use Plack::Builder;

builder {
    mount '/'      => Simple::YubiAuth->to_app;
    mount '/admin'      => Simple::YubiAuth_admin->to_app;
}

=end comment

=cut

