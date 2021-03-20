#!/usr/bin/env bash

dir=`dirname "$0"`

source $dir/config.sh

echo "Génération de la requête SQL de chargement..."

rm $dir/../sql/loadData.sql

for table in acheteurs contrats titulaires marches
do
    echo "
    TRUNCATE TABLE $table;
    LOAD DATA LOCAL INFILE '$scpPath/$table.csv' INTO TABLE $table FIELDS TERMINATED BY ',' ENCLOSED BY '\"';
    " >> $dir/../sql/loadData.sql
done

echo "Envoi des données vers le serveur..."
scp $dir/../csv/*.csv $sshHost:$scpPath

#echo "Ajout du bon path dans les requêtes SQL..."

#sed "s,scpPath,$scpPath," $dir/../sql/loadData.sql  > $dir/../sql/loadDataRemote.sql

echo "Envoi des scripts vers le serveur..."
scp $dir/../sql/*.sql $sshHost:$scpPath

ssh $sshHost "mysql --user $mysqlUser -p$mysqlPassword --database decp < $scpPath/loadData.sql"

#ssh $sshHost "mysql --user=$mysqlUser --password=$mysqlPassword --database=decp -e 'select * from titulaires''"
