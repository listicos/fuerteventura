<?php

//require_once(dirname(__FILE__) . '/../config.php');

class Core_template {

    protected $template_path, $config, $title, $js, $css, $base_url, $template_url, $views, $template_dir, $js_vars;
    protected $atributes = array();

    public function __construct($template = 'template.php') {
        global $site_title, $base_url, $template_url, $template_dir;
        $this->js = array();
        $this->css = array();
        $this->title = $site_title;
        $this->base_url = $base_url;
        $this->views = array();
        $this->template_url = $template_url;
        $this->template_dir = $template_dir;
        $this->js_vars = array();

        $this->template_path = $template_dir . DIRECTORY_SEPARATOR . $template;
    }

    public function setTemplate($template) {
        $this->template_path = $template;
    }

    public function getTemplate() {
        return $this->template_path;
    }

    public function setView($views) {
        if (is_array($views)) {
            foreach ($views as $key => $view) {
                if (is_string($view))
                    $views[$key] = $this->template_dir . DIRECTORY_SEPARATOR . $view;
            }
            $this->views = array_merge($this->views, $views);
        } else {
            if (is_string($views))
                $views = $this->template_dir . DIRECTORY_SEPARATOR . $views;

            array_push($this->views, $views);
        }
    }

    public function cleanViews() {
        $this->views = array();
    }

    public function getViews() {
        return $this->views;
    }

    public function getView($child) {
        return $this->views[$child];
    }

    public function getCSS() {
        return $this->css;
    }

    public function setCSS($css) {
        if (is_array($css)) {
            $this->css = array_merge($this->css, $css);
        } else {
            array_push($this->css, $css);
        }
    }

    public function getJS() {
        return $this->js;
    }

    public function setJS($js) {
        if (is_array($js)) {
            $this->js = array_merge($this->js, $js);
        } else {
            array_push($this->js, $js);
        }
    }

    public function setTitle($title) {
        $this->title = $title;
    }

    public function getTitle() {
        return $this->title;
    }

    public function setAttribute($key, $val) {
        $this->atributes[$key] = $val;
    }

    
    public function getAttribute($key) {
        if (isset($this->atributes[$key]))
            return $this->atributes[$key];
    }

    public function setJsVar($key, $val) {
        $this->js_vars[$key] = $val;
    }

    public function getJsVars() {
            return $this->js_vars;
    }

    public function render() 
	{
	//	echo $this->template_path;
        $file = file_get_contents($this->template_path);
	    return eval("?>$file");
    }

    public function getContent() {
        ob_start();
        $this->render();
        $content = ob_get_contents();
        @ob_end_clean();
        return $content;
    }

}

?>