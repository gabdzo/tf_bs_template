provider "aws" {
  region = ${{ values.region | dump }}
  assume_role {
    role_arn = ${{ values.aws_role | dump }}
  }
}

terraform {
  backend "s3" {
    bucket         = ${{ values.s3_state | dump }}
    dynamodb_table = ${{ values.dynamodb_state | dump }}
    encrypt        = true
    key            = ${{ values.key | dump }}
    region         = ${{ values.region | dump }}
  }
}

{% for item in values.arrayObjects %}
module ${{item.name | dump }} {
  source=${{item.source | dump}}
  ${{item.attributes}}
}
{% else %}
  No modules were selected.
{% endfor %}
