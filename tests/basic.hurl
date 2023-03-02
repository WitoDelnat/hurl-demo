POST {{api_origin}}/graphql
Authorization: Bearer {{access_token}}

```graphql
query getDefaultBranch($owner: String!, $repo: String!) {
  getRepository(
    input: { repositoryIdentifierInput: { owner: $owner, name: $repo } }
  ) {
    defaultBranch
  }
}

variables {
  "owner": "kubeshop",
  "repo": "monokle-saas"
}
```

HTTP 200
[Asserts]
duration < 1500
jsonpath "$.data.getRepository.defaultBranch" == "main"
