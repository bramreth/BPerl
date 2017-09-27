#!/usr/bin/perl -w
use strict;
use warnings;
use Term::ANSIColor;
my $searchterm = shift;
my $toggle = shift;
my $newDir = shift;
my $PearlDir = "/Volumes/notFusion/gamedev/Companies/Feral/Development/Resources/Pearl";
if(-d $newDir){$PearlDir = $newDir;}
if(defined($searchterm)){
  if(-d $PearlDir){
    chomp($searchterm);
    print color('blue');
  	print "searching for sub ($searchterm) in PearlDir\n";
  	print color('reset');
    
      #recursive and print line
      if($toggle){
        if(system("grep -rn --color=auto '$searchterm' $PearlDir")){
        print color('red');
        print "sub $searchterm - not found\n";
        print color('reset'); 
        }
      }else{
        if(system("grep -rn --color=auto 'sub $searchterm' $PearlDir")){
        print color('red');
        print "sub $searchterm - not found\n";
        print color('reset'); 
        }
      }
  }else{
  	print color('red');
	print "invalid PearlDir\n";
	print color('reset');
    
  }
}else{
	print color('magenta');
	print "no search term arg provided\n";
	print color('reset');
  
}
