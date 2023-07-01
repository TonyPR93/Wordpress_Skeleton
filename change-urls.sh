#!/bin/bash

docker-compose exec mysql mysql -uroot -ppassword my-wpdb

UPDATE wp_options SET option_value = replace(option_value, 'http://127.0.0.3:8080', 'http://www.newurl') WHERE option_name = 'home' OR option_name = 'siteurl';

UPDATE wp_posts SET guid = replace(guid, 'http://127.0.0.3:8080','http://www.newurl');

UPDATE wp_posts SET post_content = replace(post_content, 'http://127.0.0.3:8080', 'http://www.newurl');

UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://127.0.0.3:8080','http://www.newurl');

exit;

echo "Changement url fait."