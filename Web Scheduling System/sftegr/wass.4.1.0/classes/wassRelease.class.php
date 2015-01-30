<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class contains the current release of WASS, and a utility function to compare releases.
 
*/

class wassRelease {

	const RELEASE = "4.1.0";
	
	
	/* Static (class) methods */
	
	/* 
	This function compares two releases and returns either 'GT', 'EQ or 'LT' depending on whether 
	the first release is greater than, equal to or less than the second release.
	*/
	
	static function Compare($first,$second) {
		
		if (!$first)
			$first = array(0);
		else
			$first = explode('.',$first);
		if (!$second)
			$second = array(0);
		else
			$second = explode('.',$second);
	
		
		/* Zero-fill the two arrays so that they have the same length */
		while (count($first) < count($second))
			$first[] = 0;
		while (count($second) < count($first))
			$second[] = 0;
			
		/* Now compare and return the appropriate boolean */
		for ($i = 0; $i < count($first); $i++) {
			if ($first[$i] < $second[$i])
				return 'LT';
			elseif ($first[$i] > $second[$i])
				return 'GT';
		}
		
		return 'EQ';
		
	}


	/* This function compares a release with the current release and returns 'LT', 'GT' or 'EQ'
	   depending on whether the target is less than , greater than or equal to the current release. */
	static function CompareToCurrent($release) {
		
		return self::Compare($release,self::RELEASE);
		
	}
	
}
?>