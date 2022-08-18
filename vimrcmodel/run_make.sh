#!/bin/bash

if [ $# -le 1 ]; then
  echo "Usage: $0 <container_id> <directory_in_container> [ <make_args> ... ]"
  exit 1
fi

container=$1
directory=$2
shift 2

commands="source /home/ci/catkin_ws/devel/setup.bash\n\
source /home/ci/python_env/bin/activate\n\
echo 'Running make $@'\n\
make -C $directory $@"

echo -e "$commands" | docker exec -i $container bash
