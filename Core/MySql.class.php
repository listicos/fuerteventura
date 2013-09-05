<?php

class MySql{

	var $defaultPage	= 0;
	var $defaultLimit	= 10;
	
	function limit($args){
		$limit = "";
		if(isset($args["page"])){
			if($args["page"]=="")
				$args["page"] = $this->defaultPage;
			if(!isset($args["limit"]) || $args["limit"]=="")
				$args["limit"] = $this->defaultLimit;
			$limit = " LIMIT ".$args["page"]*$args["limit"].", ".$args["limit"];
		}
		return $limit;
	}
	
	function prepare($object, $data){
	
		foreach ($object as $key => $value) {
			if(isset($data[$key]))
				$object->$key = $data[$key];
		}
		return $object;
	}
	
	function addFilters($table, $args=array(), $exclude=array()){
		$filter = " WHERE 1";
		foreach ($args as $key => $value){
			if (!in_array($key, $exclude)) {
				$filter .= " AND ".$table.".".$key."='".$value."'";
			}
		}
		return $filter;
	}
}

?>