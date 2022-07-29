# common #
action="applying terraform"

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

while getopts t:b:p:o: flag
do
    case "${flag}" in
       t) tfm_folder=${OPTARG};;
       b) backend_config=${OPTARG};;
       p) tfm_plan=${OPTARG};;
       o) tfm_outputs=${OPTARG};;
    esac
done

log_header "terraform_folder" $tfm_folder
log_header "backend_config" $backend_config
log_header "terraform_plan" $tfm_plan
log_header "terraform_outputs_file" $tfm_outputs

wrk_dir=$(pwd)
cd "$wrk_dir/$tfm_folder"
    terraform init \
        -backend-config="$wrk_dir/$backend_config"
    terraform apply "$wrk_dir/$tfm_plan"
    if [ "$tfm_outputs" != "" ]; then 
        tfm_outputs="$wrk_dir/$tfm_outputs"
        mkdir -p $(dirname $tfm_outputs)
        terraform output -json >> $tfm_outputs
    fi
cd "$wrk_dir"