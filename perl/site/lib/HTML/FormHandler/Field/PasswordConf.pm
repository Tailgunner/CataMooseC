package HTML::FormHandler::Field::PasswordConf;
# ABSTRACT: password confirmation

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Text';
our $VERSION = '0.03';


has '+widget'           => ( default => 'password' );
has '+password'         => ( default => 1 );
has '+required'         => ( default => 1 );
has '+required_message' => ( default => 'Please enter a password confirmation' );
has 'password_field'    => ( isa     => 'Str', is => 'rw', default => 'password' );
has 'pass_conf_message' => (
    isa     => 'Str',
    is      => 'rw',
    default => 'The password confirmation does not match the password'
);

sub validate {
    my $self = shift;

    my $value    = $self->value;
    my $password = $self->form->field( $self->password_field )->value;
    if ( $password ne $self->value ) {
        $self->add_error( $self->pass_conf_message );
        return;
    }
    return 1;
}

__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::PasswordConf - password confirmation

=head1 VERSION

version 0.32002

=head1 DESCRIPTION

This field needs to be declared after the related Password field (or more
precisely it needs to come after the Password field in the list returned by
the L<HTML::FormHandler/fields> method).

=head2 password_field

Set this attribute to the name of your password field (default 'password')

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

