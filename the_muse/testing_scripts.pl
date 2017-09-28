#!/usr/bin/perl -w
use strict;
use warnings;
#========================================================================
#	Tests
#
#	prior to each test script I will lay out what I am trying to do
#	and find, but I won't be particularly rigorous about it.
#========================================================================

#========================================================================
#	shorthand if
#
#	I want to keep multiple calls that pass in undef to a function working
#	as they already do. So I will take a value that is defined, then if
#	it isnt defined pass in a value.
#========================================================================

my $value = shift;
print $value ? 0 : 1, "\n";
existing_function($value ? undef : 1);

sub existing_function{
	my ( $argument ) = @_;
	if( $argument )
	{
		print "success!\n";
	}
}