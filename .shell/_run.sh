set -e 
docker build -t al2_shell .
WORKING_DIR=$(bash -c "cd .. && pwd")
HOME_DIR=$(bash -c "cd ~ && pwd")
docker run \
    --rm \
    --interactive \
    --tty \
    --privileged \
    --user developer \
    --publish 4000:4000 \
    --volume "$WORKING_DIR":"/workspace":rw \
    --volume "$HOME_DIR/.ssh":"/home/developer/.ssh":rw \
    --volume "$HOME_DIR/.aws":"/home/developer/.aws":rw \
    --workdir "/workspace" \
    al2_shell "/bin/bash" 