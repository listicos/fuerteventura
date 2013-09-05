<?php

/**
 * Description of Paginator
 *
 * @author listico
 */
class Core_Util_Paginator {

    protected $total, $current_page, $per_page, $max_pages;

    public function __construct($total, $current_page = 1, $per_page = 10, $max_pages = 7) {
        $this->total = $total;
        $this->current_page = $current_page;
        $this->per_page = $per_page;
        $this->max_pages = $max_pages;
    }

    public function getHtml() {
        $paginator = new Core_template('Util/paginator.php');
        $paginator->setAttribute('total', $this->total);
        $paginator->setAttribute('current_page', $this->current_page);
        $paginator->setAttribute('per_page', $this->per_page);
        $paginator->setAttribute('max_pages', $this->max_pages);        
        //$page_number = round($this->total / $this->per_page);
        $temp=($this->total / $this->per_page)-(int)($this->total / $this->per_page);
        if($temp>0){
            $page_number=(int)($this->total / $this->per_page)+1;
        }else{
            $page_number=(int)($this->total / $this->per_page);
        }
        
        if ($this->max_pages < $page_number) {
            $paginator->setAttribute('division', true);
        }else
            $paginator->setAttribute('division', false);

        $paginator->setAttribute('pages_number', $page_number);
        return $paginator->getContent();
    }

}

?>
