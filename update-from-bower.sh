if [ -e src/Native/Chart.js ]
then
  rm src/Native/Chart.js
fi

# This is the last 1.x release
bower install --allow-root chartjs#a62537a80029cd5a2e230769a652904e2de2d5d4

# Linux
if [ -e bower_components/Chart.js/Chart.js ]
then
  cp bower_components/Chart.js/Chart.js src/Native
fi

# Mac
if [ -e bower_components/chartjs/Chart.js ]
then
  cp bower_components/chartjs/Chart.js src/Native
fi

rm -r bower_components
