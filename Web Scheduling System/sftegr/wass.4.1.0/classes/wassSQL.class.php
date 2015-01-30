<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This (static) class stores the database handle and handles all SQL interactions.
 
*/

class wassSQL {

	/* Private variable holds the database handle. */
	private static $DBHANDLE = false;
	
	/* Set our character set. */	
	private static $CHARSET = 'latin1';
	
	/* Method to set the DBHANDLE */
	static function SetHandle () {
		if (!self::$DBHANDLE) {
			if (!self::$DBHANDLE = mysql_connect(wassParms::HOST, wassParms::USER, wassParms::PASS)) {
				die('Please report the following MySQL error to your IT support staff: ' . mysql_error());
			}
			/* If successful, set the character set to latin-1 */
			if (self::$DBHANDLE) {
				$cset = false;
				if (function_exists('mysql_set_charset'))
					$cset = mysql_set_charset(self::$CHARSET,self::$DBHANDLE);
				if (!$cset)
					mysql_query('SET NAMES "' . $CHARSET . '"',self::$DBHANDLE);
			}
		}	
	}

	/* Method to get the DBHANDLE */
	static function GetHandle () {	
		return self::$DBHANDLE;	
	}
	
	/* Open the database and set the handle variable. */
	static function openDB() {
		/* If not open, try to open the database */
		if (!self::$DBHANDLE) {
			self::SETHANDLE();
		} 	
		return self::$DBHANDLE;	
	}
	
	/*
	This method executes a sepcified query and returns the php resource that
	results from the query. 
	*/	
	static function doQuery($query) {
		/* If not open, try to open the database */
		if (!self::$DBHANDLE) {
			self::SETHANDLE();
		}
		/* Execute the query. */
		$ret = mysql_query($query);
		/* If error, log the error */
		if ($ret === false) {
			wassMsg::logMsg('Mysql error ' . mysql_errno() . ' = ' . mysql_error() . '. Generated from query: ' . $query . "\r\n");
		}
		return $ret;
	}

	/*
	This method loads the 'next' result from a php resource into an associative array and returns the results. 
	*/	
	static function doFetch($resource) {
		/* If not open, try to open the database */
		if (!self::$DBHANDLE) {
			self::SETHANDLE();
		}
		/* Execute and return the result. */
		return mysql_fetch_assoc($resource);	
	}

	/*
	This method returns the number of rows affected by the last query.
	*/
	static function affected_rows() {
		/* Execute and return the result. */
		return mysql_affected_rows(self::$DBHANDLE);
	}

	/*
	This function returns the number of rows available from the latest query.
	*/
	static function num_rows($resource) {
		if (!self::$DBHANDLE) {
			return 0;
		}
		/* Execute and return the result. */
		return mysql_num_rows($resource);
	}


	/*
	This method releases a query results resources.  
	*/	
	static function freeQuery($resource) {
		/* Free the resource. */
		mysql_free_result($resource);
		return;	
	}


	/*
	This method returns the latest id number from an insert operation.
	*/
	static function insert_id() {
		/* Execute and return the result. */
		return mysql_insert_id(self::$DBHANDLE);
	}


	/*
	This method issues a SELECT against a specified database table, building
	a WHERE clause as per the arguments (an associative array).  It returns the
	php resource that results from the query, or NULL.
	*/

	static function selectDB($table, $arr) {
		/* If not open, try to open the database */
		if (!self::$DBHANDLE) {
			self::SETHANDLE();	
		}	
		/* Build the select string and return the results. */
		return self::doQuery(self::buildSelect($table,$arr));

	}

	/*
	This function returns the latest error message from the last SQL query.
	*/
	static function error() {
		/* Execute and return the result. */
		return mysql_error(self::$DBHANDLE);
	}

	/* 
	This function returns a MySQL query string from the supplied argument array.
	The array contains variable names and value; the variable names may include a
	comma and an operator to be used for the SELECT (default operator is equal).
	The variables are ANDED together, unless another connector is passed.
	*/
	static function buildSelect($table, $arr, $orderby='') {
		/* If not open, try to open the database */
		if (!self::$DBHANDLE) {
			self::SETHANDLE();
		}
		/* Build the SELECT string */
		$select = 'SELECT * FROM ' . wassParms::DATABASE . '.' . $table . ' WHERE ';
		$first = true;
		$connect = 'AND';
		foreach ($arr as $key => $value) {
			/* Allow caller to specify key AND comparator AND connector */
			list($kkey,$operator,$connector,$paren) = explode(',',$key);
			if (!$operator)
				$operator = '=';
			/* Add conector to the select string */	
			if (!$first) 
				$select .= ' ' . $connect . ' ';
			else
				$select .= '(';
			/* Add sub-paren if requested */
			if ($paren == '(')
				$select .= '(';
			/* Add ckey and operator to the select string */	
			if ($operator == 'LIKE')
				$select .= $kkey . ' LIKE ';
			else
				$select .= $kkey . $operator;
			/* Add value to the connect string */
			$select .= self::sqlSafe($value);
			/* Add closing paren if requested */
			if ($paren == ')')
				$select .= ')';
			/* Reset connector if requested */
			if ($connector) 
				$connect = $connector;
			$first = false;
		}
		/* Terminate the string and add any orderby specified */
		$select .= ') ' . $orderby;
		/* Return the select string. */
		return $select;
	}

	/* 
	This function returns a MySQL query string from the supplied argument 
	array of arrays.
	The arrays contains variable names and value; the variable names may include a
	comma and an operator to be used for the SELECT (default operator is equal).
	The variables are ANDED together, unless another connector is passed.
	*/
	static function buildOrderedSelect($table, $arr, $orderby='', $fields) {
		/* If not open, try to open the database */
		if (!self::$DBHANDLE) {
			self::SETHANDLE();
		}
		/* Build the SELECT string */
		$select = 'SELECT ';
		if ($fields) 
			$select .= $fields;
		else
			$select .= '*';
		$select .= ' FROM ' . wassParms::DATABASE . '.' . $table . ' WHERE ';
		$first = true;
		$connect = 'AND';
		foreach ($arr as $subarray) {
			/* Allow caller to specify key AND comparator AND connector */
			list($kkey,$operator,$connector,$paren) = explode(',',$subarray[0]);
			if (!$operator)
				$operator = '=';
			/* Add conector to the select string */	
			if (!$first) 
				$select .= ' ' . $connect . ' ';
			else
				$select .= '(';
			/* Add sub-paren if requested */
			if ($paren == '(')
				$select .= '(';
			/* Add ckey and operator to the select string */	
			if ($operator == 'LIKE')
				$select .= $kkey . ' LIKE ';
			else
				$select .= $kkey . $operator;
			/* Add value to the connect string */
			$select .= self::sqlSafe($subarray[1]);
			/* Add closing paren if requested */
			if ($paren == ')')
				$select .= ')';
			/* Reset connector if requested */
			if ($connector) 
				$connect = $connector;
			/* Reset first flag */
			$first = false;
		}
		/* Terminate the string and add any orderby specified */
		$select .= ') ' . $orderby;
		/* Return the select string. */
		return $select;
	}

			
	/* 
	This function sanitizes an output string for use in an SQL query.
	 */
	static function sqlSafe($value) {
 		// Stripslashes
   		if (get_magic_quotes_gpc()) {
       		$ret = stripslashes($value);
   		}
		else
			$ret = $value;
   		// Quote if not a number or a numeric string
   		if (!(is_numeric($ret))) {
			$link = self::openDB();
       		return "'" . mysql_real_escape_string($ret, $link)	 . "'";
		}
		else
			return $ret;
	}	

	
	/*
	This function converts a date to SQL format.
	*/
	static function sqlDate($date) {
		if (strpos($date,'-') !== false)
			return $date;
		else {
			list($m,$d,$y) = explode('/',$date);
			return sprintf("%04u-%02u-%02u", $y, $m, $d);
		}
	}


}
?>