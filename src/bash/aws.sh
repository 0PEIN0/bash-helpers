s3MoveFilesFromLocal() {
  if [ -z "$1" ]; then
    echo "null value is not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -z "$2" ]; then
    echo "null value is not allowed as second parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $2
  fi;
  if [ -z "$3" ]; then
    echo "null value is not allowed as third parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $3
  fi;
  cd $1
  aws s3 mv $1 s3://$2 --region=$3 --recursive
}

s3CmdMakePrivate() {
  if [ -z "$1" ]; then
    echo "null value is not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -z "$2" ]; then
    echo "null value is not allowed as second parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $2
  fi;
  if [ -z "$3" ]; then
    echo "null value is not allowed as third parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $3
  fi;
  cd $1
  s3cmd setacl --access_key=$2 --secret_key=$2 --acl-private --recursive s3://$1
}

alias aws_configure="aws configure"
alias s3_move_files_from_local=s3MoveFilesFromLocal
alias s3_cmd_configure="s3cmd --configure"
alias s3_cmd_make_private=s3CmdMakePrivate
