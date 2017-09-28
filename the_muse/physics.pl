#!/usr/bin/perl -w
use strict;
use warnings;
#========================================================================
#	Motion.
#	If there is one thing I learnt from my few years of intense
#	study of maths and physics its that as far as engineering
#	is concerned you can map a system in motion reasonably
#	articulately using 5 variables:
#
#		S - distance
#		U - initial velocity
#		V - final velocity
#		A - Acceleration
#		T - Time
#
#	by being keenly aware of all the objects interacting in a
#	system, you can predict a lot of behavior. Additionaly,
#	given just a few of these values the rest can be calculated.
#	as I progress I will more explicitly explain more fundamental
#	concepts however in the mean time I will dive in with the 
#	helper functions that will model a system.
#========================================================================
Motion(100,0,undef,undef,9.58);
#Motion(shift,shift,shift,shift,shift);
#========================================================================
#	Motion
#========================================================================
#
# Notes: this is the broadest of the functions and will call into the 
#	smaller helper functions. It will attemp to assign all of the 
#	values for a closed system.
#	In the future it may be benefical to have a name but names
#	can be relevant variable side.
#
#		S - distance - metres - m
#		U - initial velocity - metres per second - m/s
#		V - final velocity - metres per second -m/s
#		A - Acceleration - change in metres per second - ms^-2
#		T - Time - seconds - s
#
# Input: 5 integers, S, U, V, A, T.
#
# Output: A reference to an object of this contained system
#========================================================================
sub Motion{
	my ( $S, $U, $V, $A, $T) = @_;
    my %equation_hash = (
	    "s"  => $S,
	    "u"  => $U,
	    "v"  => $V,
	    "a"  => $A,
	    "t"  => $T,
    );
	my @formula_list;
	my @var_list = ();
	if( defined($S))
	{
		print("Distance (S) = $S metres.\n");
		push @var_list, "s";
	}
	if( defined($U))
	{
		print("Initial velocity (U) = $U metres per second.\n");
		push @var_list, "u";
	}
	if( defined($V))
	{
		print("Final velocity (V) = $V metres per second.\n");
		push @var_list, "v";
	}
	if( defined($A))
	{
		print("Acceleration (A) = $A metres per second per second.\n");
		push @var_list, "a";
	}
	if( defined($T))
	{
		print("Time (T) = $T seconds.\n");
		push @var_list, "t";
	}
	if( scalar @var_list < 3){
		print("too few variables to calculate more.\n");
	}elsif(scalar @var_list == 3){
		@formula_list = Trim_list(@var_list);
		print @formula_list, "\n";
		foreach my $formula (@formula_list)
		{
			calculate_motion(\%equation_hash, $formula);
		}
	}else{
		print("validating variables.\n");
	}
}
#========================================================================
#	Metre.
#	A standard unit of measurement from the International System of Units.
#	There was some issue regarding its original definition as a constant
#	which was 1 - 10 millionth the distance from the equator to the north
#	pole. which interestingly would make the vertical circumference of the 
#	earth 40 million metres.
#	It was updated to be related to the speed of light in a vacuum and thus
#	be a constant. at the distance light moves in 1/299792458 seconds.
#	which is why with rounding it is easy to say light travels 3*10^8 m/s
#
#	in actual terms a metre is about the distance from your nose to your 
#	finger tip. I would like to find a more accurate comparison however.
#========================================================================

#========================================================================
#	Trim_list
#========================================================================
#
# Notes: We have a list of suvat equations, we want to return
#	only the ones that we have enough variables to use
#
# Input: the three defined suvat variables we have
#
# Output: A list of equations we can use to finish the calculations
#========================================================================
sub Trim_list{
	my ( @var_list) = @_;
	my @formula_list = ("v=u+at","s=vt-1/2at^2","s=ut+1/2at^2","s=1/2(u+v)t","v^2=u^2+2as");
	print("@var_list\n");
	foreach my $var (@var_list)
	{
		@formula_list = grep(/$var/, @formula_list);
	}
	return @formula_list;
}

#========================================================================
#	calculate_motion
#========================================================================
#
# Notes: runs the relevant equation with variables and prints calculation
#
# Input: the hash of variables and equation
#
# Output: the resulting value
#========================================================================
sub calculate_motion{
	my $hash = shift;
	my $equation = shift;
	$equation =~ s/s/$hash->{s}/g if defined $hash->{s};
	$equation =~ s/u/$hash->{u}/g if defined $hash->{u};
	$equation =~ s/v/$hash->{v}/g if defined $hash->{v};
	$equation =~ s/a/$hash->{a}/g if defined $hash->{a};
	$equation =~ s/t/$hash->{t}/g if defined $hash->{t};
	print ($equation, "\n");
}