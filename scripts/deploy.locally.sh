# common #
action="deploying layer"

# functions #
log_action() {
    echo "${1} ..."
}

log_header() {
    echo "    $1: $2"
}

# script #
set -e
log_action $action
while getopts l:e: flag
do
    case "${flag}" in
       l) layer=${OPTARG};;
       e) environment=${OPTARG};;
    esac
done
log_header "layer" $layer
log_header "environment" $environment

tfm_folder="terraform/$layer"
backend="config/$layer/$environment/backend.tfvars"
tfm_plan="plans/$layer/$environment/tfm.plan"
tfvars="config/$layer/$environment/terraform.tfvars"
tfm_outputs="outputs/$layer/$environment/tfm.outputs.json"

source scripts/secrets.local.sh

scripts/terraform.validate.sh \
    -t $tfm_folder \
    -b true \
    -c $backend

scripts/terraform.plan.sh \
    -t $tfm_folder \
    -b $backend \
    -v $tfvars \
    -o $tfm_plan \
    -d off

scripts/terraform.apply.sh \
    -t $tfm_folder \
    -b $backend \
    -p $tfm_plan \
    -o $tfm_outputs