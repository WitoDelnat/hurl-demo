POST https://api.monokle.com/graphql
Authorization: Bearer {{access_token}}
[Options]
variable: owner=kubeshop
variable: repo=monokle-demo

```graphql
query getDefaultBranch($owner: String!, $repo: String!) {
  getRepository(
    input: { repositoryIdentifierInput: { owner: $owner, name: $repo } }
  ) {
    defaultBranch
  }
}

variables {
  "owner": "{{owner}}",
  "repo": "{{repo}}"
}
```

HTTP 200
[Captures]
branch: jsonpath "$.data.getRepository.defaultBranch"
[Asserts]
duration < 1500
variable "branch" == "main"

POST https://api.monokle.com/graphql
Authorization: Bearer {{access_token}}

```graphql
query resolveRef($owner: String!, $repo: String!, $branch: String) {
  getRepository(
    input: { repositoryIdentifierInput: { owner: $owner, name: $repo } }
  ) {
    ref(input: { name: $branch }) {
      name
      sha
    }
  }
}

variables {
  "owner": "{{owner}}",
  "repo": "{{repo}}",
  "branch": "{{branch}}"
}
```

HTTP 200
[Captures]
ref: jsonpath "$.data.getRepository.ref.sha"

GET https://api.monokle.com/content/download/github/{{owner}}/{{repo}}/{{ref}}
Origin: https://app.monokle.com
Authorization: Bearer {{access_token}}

HTTP 200
[Asserts]
duration < 10000
bytes count > 450000
