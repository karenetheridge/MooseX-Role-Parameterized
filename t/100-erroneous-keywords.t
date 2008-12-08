#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 4;

use Test::Exception;

do {
    package MyRole::Storage;
    use MooseX::Role::Parameterized;

    ::throws_ok {
        parameter()
    } qr/^You must provide a name for the parameter/;

    role {
        ::throws_ok {
            extends 'MyRole::Parameterized';
        } qr/^Roles do not currently support 'extends'/;
        ::throws_ok {
            inner()
        } qr/^Roles cannot support 'inner'/;
        ::throws_ok {
            augment()
        } qr/^Roles cannot support 'augment'/;
    };
};

Moose::Meta::Class->create_anon_class(
    roles => ['MyRole::Storage'],
);

