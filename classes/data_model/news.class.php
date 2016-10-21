<?php

/**
 * @author Poltarokov SP
 * @copyright 2012-08-27
 * 
 * CREATE TABLE `news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_head` varchar(100) NOT NULL,
  `news_short` varchar(255) NOT NULL,
  `news_text` varchar(2000) NOT NULL,
  `news_event_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_edit_date` timestamp NULL DEFAULT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;
 * 
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class News extends DataObject  {
    public $news_head;
    public $news_short;
    public $news_text;
    public $news_event_date;
    public $last_edit_date;
    public $author_name;
    
    function __construct($currency)    {
        parent::__construct($currency['news_id']);
        $this->news_head = $currency['news_head'];
        $this->news_short = $currency['news_short'];
        $this->news_text = $currency['news_text'];
        $this->news_event_date = $currency['news_event_date'];
        $this->last_edit_date = $currency['last_edit_date'];
        $this->author_name = $currency['author_name'];
    }
}

?>
