terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.40.0"
    }
    flows = {
      source  = "spacelift-io/flows"
      version = "0.2.0"
    }
  }
}

provider "spacelift" {}

provider "flows" {
  endpoint = "useflows.eu"
}

module "test" {
  source = "../"

  stack_label = "jira"

  # Get this on step 7 in the manual steps.
  signing_key = "temporary-signing-key"

  # Get this on step 5 in the manual steps.
  spacelift_api_key_id = "01KC70XKKATYCAK5Q36669XJC5"

  jira = {

    # Get custom field id from step 2 in the manual steps.
    custom_field_id = "customfield_10082"

    url         = "https://spacelift.atlassian.net/"
    email       = "joeys@spacelift.io"
    project_key = "SCRUM"

    # Get API token from step 4 in the manual steps.
    api_token = "ATATT3xFfGF0jtVGL70RuR0spHTpihLoEC9dGLktWZL33b-c4hqEUYB7Ap1_rnkTXTRH2uwHf9y3d9S-_BZfOHgxX8nlFBU8X-TgoJCd_UYKB5njGgLRjJ-14E4275"
  }

  infracost = {
    # Anything $$$ above this threshold will cause a jira issue to be created.
    threshold = 5

    # Get this from step 6 in the manual steps.
    api_key = "ico-pLlMAdJlewzr2AaMm5lF29J26J4IddeSh"
  }

  flows = {
    # Get this from step 3 in the manual steps.
    project_id = "0197b19a-cd02-7cf7-bc00-6699879cc49c"

    # Get these from Step 4 and Step 5 in the manual steps.
    jira_app_id      = "019b0e32-1920-7f0y-88f2-f9784d0946a8"
    spacelift_app_id = "019b0j43-1133-7378-ac72-9b00be3b347f"
  }

}