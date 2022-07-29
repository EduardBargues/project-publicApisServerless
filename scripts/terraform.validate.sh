# common #
action="validating terraform"

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

while getopts t:b:c: flag
do
    case "${flag}" in
       t) tfm_path=${OPTARG};;
       b) backend=${OPTARG};;
       c) backend_config=${OPTARG};;
    esac
done

log_header "tfm_path" $tfm_path
log_header "backend" $backend
log_header "backend_config" $backend_config

wrk_dir=$(pwd)
cd "$wrk_dir/$tfm_path"
    terraform init \
        -backend=$backend \
        -backend-config="$wrk_dir/$backend_config"
    terraform validate
cd "$wrk_dir"