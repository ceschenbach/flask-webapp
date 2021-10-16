STACK_NAME=$1

if [ -z "$1" ]
  then
    echo "No STACK_NAME argument supplied"
    exit 1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $DIR
#DIR="..module-2/cfn"

echo "Creating stack..."
STACK_ID=$( \
  aws cloudformation create-stack \
  --stack-name ${STACK_NAME} \
  --template-body file://${DIR}/core.yml \
  --capabilities CAPABILITY_NAMED_IAM \
  | jq -r .StackId
  #--parameters file://${DIR}/parameters.json \
  #--tags file://${DIR}/tags.json \

)

echo "Waiting on ${STACK_ID} create completion..."
aws cloudformation wait stack-create-complete --stack-name ${STACK_ID}
aws cloudformation describe-stacks --stack-name ${STACK_ID} | jq .Stacks[0].Outputs