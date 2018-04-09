<?php

require_once("../../config.php");
require_once("User.php");
require_once("Post.php");

if (isset($_POST['content']))
    $content = $_POST['content'];
else
    error_die("Missing POST field 'content'.");

$author = verify_logged_in();

$p = Post::post($author, $content);
success_die($p);