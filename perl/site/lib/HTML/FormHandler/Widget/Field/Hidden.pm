package HTML::FormHandler::Widget::Field::Hidden;
# ABSTRACT: hidden field rendering widget

use Moose::Role;
with 'HTML::FormHandler::Widget::Field::Role::HTMLAttributes';

sub render {
    my ( $self, $result ) = @_;

    $result ||= $self->result;
    my $output = "\n";
    $output .= '<input type="hidden" name="';
    $output .= $self->html_name . '"';
    $output .= ' id="' . $self->id . '"';
    $output .= ' value="' . $self->html_filter($result->fif) . '"';
    $output .= $self->_add_html_attributes;
    $output .= " />\n";

    return $output;
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Hidden - hidden field rendering widget

=head1 VERSION

version 0.32002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

