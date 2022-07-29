# common #
action="planning terraform"

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

while getopts t:b:v:o:d: flag
do
    case "${flag}" in
       t) tfm_folder=${OPTARG};;
       b) backend_config=${OPTARG};;
       v) tfvars_file=${OPTARG};;
       o) terraform_plan=${OPTARG};;
       d) destroy_mode=${OPTARG};; 
    esac
done
if [[ "${destroy_mode}" == '' ]]; then
  destroy_mode='off'
fi
log_header "terraform_folder" "$tfm_folder"
log_header "backend_config" "$backend_config"
log_header "tfvars_file" "$tfvars_file"
log_header "terraform_plan" "$terraform_plan"
log_header "destroy_mode" "$destroy_mode"

wrk_dir=$(pwd)
cd "$wrk_dir/$tfm_folder"
    terraform init \
        -backend-config="$wrk_dir/$backend_config"
    terraform_plan="$wrk_dir/$terraform_plan"
    mkdir -p $(dirname $terraform_plan)
    if [ "$destroy_mode" = "on" ]; then 
        terraform plan \
            -destroy \
            -var-file="$wrk_dir/$tfvars_file" \
            -out=$terraform_plan
    else
        terraform plan \
            -var-file="$wrk_dir/$tfvars_file" \
            -out=$terraform_plan
    fi
cd "$wrk_dir"