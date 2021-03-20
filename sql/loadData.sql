
    TRUNCATE TABLE acheteurs;
    LOAD DATA LOCAL INFILE '/var/www/phpmyadmin/acheteurs.csv' INTO TABLE acheteurs FIELDS TERMINATED BY ',' ENCLOSED BY '"';
    

    TRUNCATE TABLE contrats;
    LOAD DATA LOCAL INFILE '/var/www/phpmyadmin/contrats.csv' INTO TABLE contrats FIELDS TERMINATED BY ',' ENCLOSED BY '"';
    

    TRUNCATE TABLE titulaires;
    LOAD DATA LOCAL INFILE '/var/www/phpmyadmin/titulaires.csv' INTO TABLE titulaires FIELDS TERMINATED BY ',' ENCLOSED BY '"';
    

    TRUNCATE TABLE marches;
    LOAD DATA LOCAL INFILE '/var/www/phpmyadmin/marches.csv' INTO TABLE marches FIELDS TERMINATED BY ',' ENCLOSED BY '"';
    
