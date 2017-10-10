#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
#========================================================================
#	PerlRef - see https://perldoc.perl.org/perlref.html
#
#	this is a personal attempt to get over the bugbear that has been
#	perl references.
#	As of perl 5 scalars can hold hard references. As arrays and hashes
#	can hold scalars you can have arrays of arrays and hashes of hashes
#	etc. The hard references are smart and can automatically destruct
#	objects that aren't referred to anymore as well as freeing things
#	when they are no longer referred to.
#	In perl there is no implicit referencing or dereferencing. If you 
#	want the scalar to stop acting like a scalar you have to tell it
#	explicitly to act like a hash, subroutine or array.
#========================================================================

#========================================================================
#	Backslash works like a C & (address of)
#
#	This typically create another reference to a variable (in addition to
#	the one in the symbol table)
#========================================================================
my $var = "woah";
my @arr = (1,2,3,4,5);
my %hash = (
	"Jem" => "sweet",
	"Bram" => "nerd"
);

print \$var, "\n",\@arr, "\n",\%hash, "\n"; #this prints their hard references

#========================================================================
#	Square brackets let you refer to an anonymous array.
#========================================================================
my $anonArrayRef = [1,2,3,["a","b"]];
print $anonArrayRef->[3][1], "\n";
#========================================================================
#	a list of references is the same as a reference to a list
#	 @list = (\$a, \@b, \%c);
#    @list = \($a, @b, %c);
#========================================================================
#========================================================================
#	Curly brackets let you refer to an anonymous hash.
#========================================================================
my $anonHashRef  = {
            'Adam'  => 'Eve',
            'Clyde' => 'Bonnie',
};

#========================================================================
#	You can refer to an anonymous sub with a scalar ref! and do clever
#	things by shifting parameters in.
#========================================================================
my $anonSubRef  = sub {print "they don't allow you to have bees in here.\n@_\n";};

#========================================================================
#	*foo{thing} is fairly odd, I think its like a backslash but you 
#	declare what the reference is to. it returns a reference to the
#	{thing} in *foo. *foo is the symbol table entry for everything known
#	as foo.
#	I will update this another time, lets look at using refs
#========================================================================
#	here is some syntactic sugar for calling refs
# 	the left side of the arrow can be any expression returning a ref
$anonArrayRef->[0] = "January";   # Array element
$anonHashRef->{"KEY"} = "VALUE";  # Hash element
$anonSubRef->(1,2,3);            # Subroutine call
#========================================================================
#	autovification
#	referring to an anonymous array in a context initialises it as that
#	contexts structure. the simplest form is adding a key to a hash
#	that didn't exist before.
#========================================================================
my %auto_hash;
#dumper prints a data structure in perl syntax (needs importing)
print Dumper \%auto_hash;
$auto_hash{Foo} = '123-456';
$auto_hash{Bar}++;#perl treats the undef as 0 in this context
print Dumper \%auto_hash;
#even though foo wasn't initialised in the hash, it is still assigned
#this works with references too
my $auto_hash_2;
#dumper prints a data structure in perl syntax (needs importing)
print Dumper $auto_hash_2;
$auto_hash_2->{Foo} = '123-456';
print Dumper $auto_hash_2;
#in the output for that it changes from an undef scalar to a hash
#that is the essence of autovification
#========================================================================
#	for arrays, perl will automatically increase the arrays size up to
#	the created value., so this makes the array go from 0 to 9.
#========================================================================
my @auto_arr;
print Dumper \@auto_arr;
$auto_arr[0] = 20;
$auto_arr[9]++;
print Dumper \@auto_arr;
#========================================================================
#	autovification is best for very deep data structures.
#========================================================================
my %deep_hash;
print Dumper \%deep_hash;
$deep_hash{Foo}{Bar}{eggs}{spam} = '123-456';
print Dumper \%deep_hash;
#or with a scalar
my $deep;
print Dumper $deep;
$deep->{eggs}{spam} = '123-456';
print Dumper $deep;
#========================================================================
#	so lets mess around some - 3d array
#========================================================================
my @td_arr;
print Dumper \@td_arr;
$td_arr[3][2][4]{Bar} = 'tuna';
print Dumper \@td_arr;
#========================================================================
#	references can be used as a number, which can make it very easy to
#	check if two references refer to the same thing
#	i.e.  if ($ref1 == $ref2) { 
#========================================================================
#========================================================================
#	interpolating a sub call into a string: the block part makes it 
#	return an anonymous array which is easy to stringify
#	print "My sub returned @{[mysub(1,2,3)]} that time.\n";
#	let's test that out some.
#========================================================================
sub tuna{
	my $result = "\ntuna sub with:";
	foreach my $var (@_){
		$result.="\n	-	$var";
	}
	return $result."\n";
};
print "My sub returned a @{[tuna('salad','tomatoes', 'mayo')]} it sounds delicious.\n";
#========================================================================
#	glob filenames with wildcard characters. e.g. *.txt is a glob pattern
#	worth noting they look for an exact match, they are distinct from
#	regexes as a result.
#========================================================================