#!/bin/bash
stacks=$(curl -s --request GET \
  --url https://$PORTAINER_URL/api/stacks \
  --header "X-api-key: $PORTAINER_API_KEY")
# Get all stack names
ids=( $(echo "$stacks" | jq -r '.[] | .Id') )
names=( $(echo "$stacks" | jq -r '.[] | .Name') )
mkdir -p ./stacks
for index in "${!ids[@]}"; do
    echo "# ${names[$index]}" > ./stacks/"${names[$index]}".md
    echo "\`\`\`yaml" >> ./stacks/"${names[$index]}".md
    curl -s --request GET \
  --url https://$PORTAINER_URL/api/stacks/${ids[$index]}/file \
  --header "x-api-key: $PORTAINER_API_KEY" | jq -r '.StackFileContent' >> ./stacks/"${names[$index]}".md
  echo "\`\`\`" >> ./stacks/"${names[$index]}".md
done
