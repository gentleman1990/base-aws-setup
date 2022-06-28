#!/bin/bash

set -e

cat <<EOT >> /etc/ecs/ecs.config
ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]
ECS_CLUSTER=${cluster_name}
EOT