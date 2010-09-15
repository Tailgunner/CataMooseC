package HTML::FormHandler::Widget::Form::Simple;
# ABSTRACT: widget to render a form with divs

use Moose::Role;

with 'HTML::FormHandler::Widget::Form::Role::HTMLAttributes';
our $VERSION = 0.01;


has 'auto_fieldset' => ( isa => 'Bool', is => 'rw', lazy => 1, default => 1 );

sub render {
    my ($self) = @_;

    my $result;
    my $form;
    if ( $self->DOES('HTML::FormHandler::Result') ) {
        $result = $self;
        $form   = $self->form;
    }
    else {
        $result = $self->result;
        $form   = $self;
    }
    my $output = $form->render_start;

    foreach my $fld_result ( $result->results ) {
        die "no field in result for " . $fld_result->name
            unless $fld_result->field_def;
        $output .= $fld_result->render;
    }

    $output .= $self->render_end;
    return $output;
}

sub render_start {
    my $self = shift;

    my $output = $self->html_form_tag;

    $output .= '<fieldset class="main_fieldset">'
        if $self->form->auto_fieldset;

    return $output
}

sub render_end {
    my $self = shift;
    my $output;
    $output .= '</fieldset>' if $self->form->auto_fieldset;
    $output .= "</form>\n";
    return $output;
}

use namespace::autoclean;
1;


__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Form::Simple - widget to render a form with divs

=head1 VERSION

version 0.32002

=head1 SYNOPSIS

Role to apply to form objects to allow rendering. In your form:

   has '+widget_form' => ( default => 'Simple' );

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

