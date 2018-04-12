package Simple::YubiAuth;
use Dancer2;

use AnyEvent::Yubico;

our $VERSION = '0.1';

set session => 'Simple';

get '/' => sub {
    session('user')
        or redirect('/login');

    template 'index' => { 'title' => 'Simple::YubiAuth' };
};

get '/unprotected' => sub {
    template unprotected => {};
};

get '/protected' => sub {
    session('user')
        or redirect('/login');

    template protected => {};
};

get '/login' => sub {
    template login => {};
};

post '/login' => sub {

    my $otp = param('yubi_otp');
    my $identity = substr($otp, 0, 12);
    my $redir_url = param('redirect_url') || '/';

    # We set the valid keys here
    # Get your API key from:
    #     https://upgrade.yubico.com/getapikey/
    # And then put it in below in the format:
    # identity - Yubu Client ID : Yubi API Key : Username
    # 
    # You can add a friendly name in as the 4th parameter
    #
    # Identity comes from the first 12 letters of a OTP generated by the key
    # and saves us talking to Yubi unless we have a valid OTP.

    my %allowed_users = ('ccccccabcdef' => '12345:0oHCEE9C0ffeeC0feefeswkr7HU=:Andrew',
                         'dddddddddddd' => '12321:0oHCE7ekdmdsaewDD312DDASWHU=:Fred Blogs',
                         'ccccccbbbaab' => '32123:0o342ajkh4jk2hdsaljkh321das=:Twinkle');

    if (exists($allowed_users{$identity})) {

        my ($yubi_client_id, $yubi_api_key, $username) = split(':', $allowed_users{$identity});

        my $yk = AnyEvent::Yubico->new({client_id => $yubi_client_id, api_key => $yubi_api_key});
        my $result_details = $yk->verify_sync($otp);

        if ($result_details->{status} eq 'OK') { 
            session user => $username;
            session yubiid => $identity;
            redirect '/';
        } else {
            redirect('/login?BAD_OTP');
        }
    } else {
        redirect('/login?BAD_USER');
    }

};

any '/logout' => sub {
    app->destroy_session;
    template logout => {};
};

true;