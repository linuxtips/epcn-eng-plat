#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$DIR")"
set -ex

init_module() {
    if [ ! -d "$1/.terraform" ]; then
        tofu \
            -chdir="$1" \
            init 
    fi
}

apply_infra() {
    if [ ! -d "$1/.terraform" ]; then
        tofu \
            -chdir="$1" \
            init 
    fi
    tofu -chdir="$1" \
        apply \
        -auto-approve
}

get_output() {
    tofu -chdir="$1" output -raw "$2"
}

get_json() {
    tofu -chdir="$1" output -json "$2"
}

init_module "$REPO_DIR/infra/modules/domain"
init_module "$REPO_DIR/infra/modules/domain_certificate"
init_module "$REPO_DIR/infra/modules/domain_validation"

apply_infra "$REPO_DIR/infra/resources/domain"
export TF_VAR_zone_id=$(get_output "$REPO_DIR/infra/resources/domain" "zone_id")
echo "TF_zone_id: $TF_VAR_zone_id"

apply_infra "$REPO_DIR/infra/resources/domain_certificate"
export TF_VAR_certificate_arn=$(get_output "$REPO_DIR/infra/resources/domain_certificate" "certificate_arn")
echo "TF_certificate_arn: $TF_VAR_certificate_arn"

#TODO apply_infra "$REPO_DIR/infra/resources/domain_validation"

apply_infra "$REPO_DIR/infra/resources/foundation"
export TF_VAR_ecs_cluster_id=$(get_output "$REPO_DIR/infra/resources/foundation" "ecs_cluster_id")
echo "TF_VAR_ecs_cluster_id: $TF_VAR_ecs_cluster_id"
export TF_VAR_task_execution_role_arn=$(get_output "$REPO_DIR/infra/resources/foundation" "task_execution_role_arn")
echo "TF_VAR_task_execution_role_arn: $TF_VAR_task_execution_role_arn"
export TF_VAR_private_subnet_ids=$(get_json "$REPO_DIR/infra/resources/foundation" "private_subnet_ids")    
echo "TF_VAR_private_subnet_ids: $TF_VAR_private_subnet_ids"
export TF_VAR_ecs_security_group_id=$(get_output "$REPO_DIR/infra/resources/foundation" "ecs_security_group_id")
echo "TF_VAR_ecs_security_group_id: $TF_VAR_ecs_security_group_id"

export TF_VAR_ecr_repository_url=$(get_output "$REPO_DIR/infra/resources/foundation" "ecr_repository_url")
echo "TF_VAR_ecr_repository_url: $TF_VAR_ecr_repository_url"

export IMAGE_VERSION=$(cat "$REPO_DIR/version.txt")
export TF_VAR_service_name="go-hello"
export TF_VAR_image_tag="${TF_VAR_service_name}:${IMAGE_VERSION}"
echo "TF_VAR_image_tag: $TF_VAR_image_tag"
apply_infra "$REPO_DIR/infra/resources/go-hello"

