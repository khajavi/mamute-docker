#!/bin/bash

echo "Configuring database based on environment variables"
if [ -z "$DB_HOST" ]; then
    echo "Need to set DB_HOST"
    exit 1
fi  

if [ -z "$DB_USER" ]; then
    echo "Need to set DB_USER"
    exit 1
fi

if [ -z "$DB_PWD" ]; then
    echo "Need to set DB_PWD"
    exit 1
fi

if [ -z "$DB_NAME" ]; then
    echo "Need to set DB_NAME"
    exit 1
fi

# now substitute the DB parameters
sed 's/HOST/'"$DB_HOST"'/g' WEB-INF/classes/production/hibernate.cfg.tmp > WEB-INF/classes/production/hibernate.cfg.tmp2
sed 's/USER/'"$DB_USER"'/g' WEB-INF/classes/production/hibernate.cfg.tmp2 > WEB-INF/classes/production/hibernate.cfg.tmp3
sed 's/PORT/'"$DB_PORT"'/g' WEB-INF/classes/production/hibernate.cfg.tmp3 > WEB-INF/classes/production/hibernate.cfg.tmp4
sed 's/DATABASE/'"$DB_NAME"'/g' WEB-INF/classes/production/hibernate.cfg.tmp4 > WEB-INF/classes/production/hibernate.cfg.tmp5
sed 's/PASSWORD/'"$DB_PWD"'/g' WEB-INF/classes/production/hibernate.cfg.tmp5 > WEB-INF/classes/production/hibernate.cfg.xml

# then substitute the host parameters
sed 's/localhost/'"$MAMUTE_HOST"'/g' WEB-INF/classes/mamute.properties > WEB-INF/classes/mamute.properties.tmp1
sed 's/8080/'"$MAMUTE_PORT"'/g' WEB-INF/classes/mamute.properties.tmp1 > WEB-INF/classes/mamute.properties
#sed 's/feature.facebook.login = true/feature.facebook.login = flase/g' WEB-INF/classes/mamute.properties.tmp2 > WEB-INF/classes/mamute.properties.tmp3
#sed 's/feature.google.login = true/feature.google.login = flase/g' WEB-INF/classes/mamute.properties.tmp3 > WEB-INF/classes/mamute.properties
#echo "feature.google.login = false" >> WEB-INF/classes/mamute.properties
#echo "feature.facebook.login = false" >> WEB-INF/classes/mamute.properties

echo "Now starting Mamute"
/opt/mamute/run.sh
