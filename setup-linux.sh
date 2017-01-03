#!/usr/bin/env bash

set -eux

# http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

$script_dir/foundation/ssh/setup.sh
$script_dir/foundation/homeshick/setup.sh

source $HOME/.zandbashrc

### Trust github ###
mkdir -p .ssh
cat <<EOF >> .ssh/known_hosts
|1|6WX8FDwncDK8tfyfkLLbvyepVRw=|15RHFpHg3GHML7eJqvNL/yVYChI= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
|1|cccEMXs7ur0u/JXs4NQYv4A9Xb8=|Pddv+wa776NKeZ4v1yMn1cZWt4s= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
EOF

homeshick --batch clone bigwheel/tmux-castle
homeshick --batch link tmux-castle

homeshick --batch clone bigwheel/git-castle
homeshick --batch link git-castle
homeshick cd git-castle
./setup.sh
cd -

homeshick --batch clone bigwheel/zsh-castle
homeshick --batch link zsh-castle

homeshick --batch clone bigwheel/vim-castle
homeshick --batch link vim-castle
