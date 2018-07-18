s3MoveFilesFromLocal() {
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -z "$2" ]; then
    echo "null value not allowed as second parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $2
  fi;
  if [ -z "$3" ]; then
    echo "null value not allowed as third parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $3
  fi;
  cd $1
  aws s3 mv $1 s3://$2 --region=$3 --recursive
}

alias aws_configure="aws configure"
alias s3_move_files_from_local=s3MoveFilesFromLocal
