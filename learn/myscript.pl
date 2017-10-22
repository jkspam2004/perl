#!/usr/bin/perl -w

use strict;

# you may need to set @INC here (see below)

my @list = qw (J u s t ~ A n o t h e r ~ P e r l ~ H a c k e r !);

=pod
# case 1
use MyModule;
print func1(@list),"\n";
print func2(@list),"\n";
# complains about func1 since nothing is exported
# Undefined subroutine &main::func1 called at myscript.pl line 11.
=cut

=pod
# case 2
use MyModule qw(&func1);
print func1(@list),"\n";
print MyModule::func2(@list),"\n";
# works OK, no complaints
=cut

=pod
# case 3
use MyModule qw(:DEFAULT);
print func1(@list),"\n";
print func2(@list),"\n";
# complains about func1
# Undefined subroutine &main::func1 called at myscript.pl line 29.
# :DEFAULT is a special tag name. automatically set in module's %EXPORT_TAGS
# like DEFAULT => \@EXPORT
=cut

=pod
# case 4
use MyModule qw(:Both);
print func1(@list),"\n";
print func2(@list),"\n";
# works OK, no complaints
=cut

#=pod
# case 5
use MyModule qw(:MYDEFAULT);
print func1(@list),"\n";
print func2(@list),"\n";
# complains about func2
# Undefined subroutine &main::func2 called at myscript.pl line 49.
#=cut

#http://www.perlmonks.org/?node_id=102347
