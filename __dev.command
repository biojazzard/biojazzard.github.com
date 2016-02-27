cd "$(dirname "$0")"
bower install
if [ ! -d node_modules ];then
  npm install
fi
grunt watch
