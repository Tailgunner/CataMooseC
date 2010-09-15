package HTML::FormHandler::Widget::Field::Compound;
# ABSTRACT: compound field widget

use Moose::Role;

sub render {
    my ( $self, $result ) = @_;

    $result ||= $self->result;
    my $output = '';
    foreach my $subfield ( $self->sorted_fields ) {
        my $subresult = $result->field( $subfield->name );
        next unless $subresult;
        $output .= $subfield->render($subresult);
    }
    return $self->wrap_field( $result, $output );
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Compound - compound field widget

=head1 VERSION

version 0.32002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

