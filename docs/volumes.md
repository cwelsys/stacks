docker run --rm \
  -v <new>:/volume-dest \
  -v <old>:/volume-src \
  alpine \
  sh -c "cd /volume-src && cp -a . /volume-dest"

docker volume create --name <new> && docker run --rm -it -v <old>:/from -v <new>:/to alpine ash -c 'cd /from ; cp -av . /to' && docker volume rm <old>


docker run --rm -v <old>:/source -v <new>:/<directory> alpine cp -r /<directory>/. /<directory>/<path>/<..>
