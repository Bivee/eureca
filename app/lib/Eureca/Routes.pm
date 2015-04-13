package Eureca::Routes;
use Mojo::Base -strict;

sub register {
    my ($self, $r) = @_;

    # Home 
    $r->get('/' => sub { 
        return shift->render( inline => qq{
            <h1>Home Page</h1>
            <a href="/app">Load App</a>
        }); 
    });

    # Account controller
    my $account = $r->any('/account');
    $account->any('/signin')->to('Account#signin');
    $account->get('/signout')->to('Account#signout');
    $account->any('/register')->to('Account#register');
    $account->get('/forgot')->to('Account#forgot');

    # auth area
    my $auth = $r;
    #my $auth = $r->under(sub{
    #    my $c = shift;

    #    return 1 if $c->session('uid');
    #    $c->flash(error => 'session-expired') 
    #        && return $c->redirect_to('/account/signin');
    #});

    #$r->get('/' => sub{ shift->redirect_to('/app') });

    # Home controller
    my $home = $auth->any('/app');
    $home->get('/')->to('Home#index');


    # Api end-points
    my $api = $r->any('/api');
    $api->get('/idea')->to(controller => 'API::Idea', action => 'list');
    $api->put('/idea')->to(controller => 'API::Idea', action => 'update');
    $api->post('/idea')->to(controller => 'API::Idea', action => 'create');
}

1;
