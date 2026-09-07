# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "manage_service_catalog"
resource "port_folder" "manage_service_catalog" {
  provider   = port-labs
  identifier = "manage_service_catalog"
  parent     = null
  title      = "Manage service catalog"
}

# __generated__ by Terraform from "catalog_tables"
resource "port_folder" "catalog_tables" {
  provider   = port-labs
  after      = "manage_service_catalog"
  identifier = "catalog_tables"
  parent     = null
  title      = "Catalog tables"
}

# __generated__ by Terraform from "environment"
resource "port_blueprint" "environment" {
  provider                      = port-labs
  calculation_properties        = null
  create_catalog_page           = true
  description                   = null
  force_delete_entities         = false
  icon                          = "Environment"
  identifier                    = "environment"
  include_in_global_search      = null
  kafka_changelog_destination   = null
  mirror_properties             = null
  ownership                     = null
  properties                    = null
  relations                     = null
  title                         = "Environment"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "service:dora_deploy_freq"
resource "port_scorecard" "dora_deploy_freq" {
  provider   = port-labs
  blueprint  = "service"
  filter     = null
  identifier = "dora_deploy_freq"
  levels     = null
  rules = [
    {
      description = "DORA Elite tier"
      identifier  = "github_svc_df_elite"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"deployment_frequency\",\"value\":7}"]
      }
      title = "Deploys at least daily (>= 7/week)"
    },
    {
      description = "DORA Medium tier"
      identifier  = "github_svc_df_medium"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"deployment_frequency\",\"value\":0.25}"]
      }
      title = "Deploys at least monthly (>= 0.25/week)"
    },
    {
      description = "DORA High tier"
      identifier  = "github_svc_df_high"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"deployment_frequency\",\"value\":1}"]
      }
      title = "Deploys at least weekly (>= 1/week)"
    },
  ]
  title = "Deployment Frequency"
}

# __generated__ by Terraform from "githubUser"
resource "port_blueprint" "githubUser" {
  provider                    = port-labs
  calculation_properties      = null
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Github"
  identifier                  = "githubUser"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties           = null
  ownership                   = null
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      email = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Email"
      }
      login = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Login"
      }
    }
  }
  relations = {
    team = {
      description = null
      many        = true
      required    = false
      target      = "githubTeam"
      title       = "GitHub Team"
    }
  }
  title                         = "GitHub User"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "githubRepository"
resource "port_aggregation_properties" "githubRepository_aggregation_properties" {
  provider             = port-labs
  blueprint_identifier = "githubRepository"
  properties = {
    failed_workflow_runs_30d = {
      description = "Workflow runs that ended in failure in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastMonth"
          }
          }, {
          operator = "="
          property = "conclusion"
          value    = "failure"
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Monthly Failed Workflow Runs"
    }
    failed_workflow_runs_7d = {
      description = "Workflow runs that ended in failure in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
          }, {
          operator = "="
          property = "conclusion"
          value    = "failure"
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Weekly Failed Workflow Runs"
    }
    merged_prs_last_month = {
      description = "Pull requests merged in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Monthly PR Throughput"
    }
    merged_prs_last_week = {
      description = "Pull requests merged in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Weekly PR Throughput"
    }
    open_prs = {
      description = "Open pull requests"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "status"
          value    = "open"
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Open PRs"
    }
    pr_cycle_time = {
      description = "Average time from PR creation to merge (last month)"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property = {
          average_of      = "total"
          measure_time_by = "$createdAt"
          property        = "cycle_time_hours"
        }
        average_entities = null
        count_entities   = null
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Monthly PR Cycle Time"
    }
    pr_cycle_time_weekly = {
      description = "Average time from PR creation to merge (last week)"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property = {
          average_of      = "total"
          measure_time_by = "$createdAt"
          property        = "cycle_time_hours"
        }
        average_entities = null
        count_entities   = null
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Weekly PR Cycle Time"
    }
    stale_prs_7d = {
      description = "Open PRs older than 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "status"
          value    = "open"
          }, {
          operator = "notBetween"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Stale PRs (7d+)"
    }
    workflow_runs_30d = {
      description = "Total workflow runs in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Monthly Workflow Runs"
    }
    workflow_runs_7d = {
      description = "Total workflow runs in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Weekly Workflow Runs"
    }
  }
}

# __generated__ by Terraform from "deployment"
resource "port_blueprint" "deployment" {
  provider                    = port-labs
  calculation_properties      = null
  create_catalog_page         = true
  description                 = "A production deployment created from a merged PR to the default branch"
  force_delete_entities       = false
  icon                        = "Deployment"
  identifier                  = "deployment"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties = {
    github_lead_time_hours = {
      path  = "github_pull_request.cycle_time_hours"
      title = "Lead Time for Changes (Hours)"
    }
    github_repo_id = {
      path  = "github_pull_request.repository.$identifier"
      title = "GitHub Repository ID"
    }
  }
  ownership = null
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      createdAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Deployment Time"
      }
      deploymentStatus = {
        date_format = null
        default     = null
        description = null
        enum        = ["Success", "Failure", "Pending"]
        enum_colors = {
          Failure = "red"
          Pending = "yellow"
          Success = "green"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Deployment Status"
      }
      environment = {
        date_format = null
        default     = null
        description = null
        enum        = ["Production", "Staging", "Development"]
        enum_colors = {
          Development = "blue"
          Production  = "green"
          Staging     = "yellow"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Environment"
      }
    }
  }
  relations = {
    github_pull_request = {
      description = null
      many        = false
      required    = false
      target      = "githubPullRequest"
      title       = "Pull Request"
    }
    service = {
      description = null
      many        = false
      required    = false
      target      = "service"
      title       = "Service"
    }
  }
  title                         = "Deployment"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "service"
resource "port_aggregation_properties" "service_aggregation_properties" {
  provider             = port-labs
  blueprint_identifier = "service"
  properties = {
    deployment_frequency = {
      description = "Successful PR Merges per Week"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities = {
          average_of      = "week"
          measure_time_by = "createdAt"
        }
        count_entities = null
      }
      path_filter = [
        {
          from_blueprint = "deployment"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "deploymentStatus"
          value    = "Success"
          }, {
          operator = "="
          property = "environment"
          value    = "Production"
        }]
      })
      target_blueprint_identifier = "deployment"
      title                       = "Deployment Frequency (per week)"
    }
    github_failed_workflow_runs_30d = {
      description = "Workflow runs that ended in failure in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubWorkflowRun"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastMonth"
          }
          }, {
          operator = "="
          property = "conclusion"
          value    = "failure"
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Monthly Failed Workflow Runs"
    }
    github_failed_workflow_runs_7d = {
      description = "Workflow runs that ended in failure in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubWorkflowRun"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
          }, {
          operator = "="
          property = "conclusion"
          value    = "failure"
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Weekly Failed Workflow Runs"
    }
    github_lead_time_for_change = {
      description = "Average time from PR creation to merge in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property = {
          average_of      = "total"
          measure_time_by = "$createdAt"
          property        = "cycle_time_hours"
        }
        average_entities = null
        count_entities   = null
      }
      path_filter = [
        {
          from_blueprint = "githubPullRequest"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Lead Time for Changes (Hours)"
    }
    github_merged_prs_last_month = {
      description = "Pull requests merged in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubPullRequest"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Monthly PR Throughput"
    }
    github_merged_prs_last_week = {
      description = "Pull requests merged in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubPullRequest"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Weekly PR Throughput"
    }
    github_open_prs = {
      description = "Open pull requests"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubPullRequest"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "status"
          value    = "open"
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Open PRs"
    }
    github_pr_cycle_time = {
      description = "Average time from PR creation to merge (last month)"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property = {
          average_of      = "total"
          measure_time_by = "$createdAt"
          property        = "cycle_time_hours"
        }
        average_entities = null
        count_entities   = null
      }
      path_filter = [
        {
          from_blueprint = "githubPullRequest"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Monthly PR Cycle Time"
    }
    github_pr_cycle_time_weekly = {
      description = "Average time from PR creation to merge (last week)"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property = {
          average_of      = "total"
          measure_time_by = "$createdAt"
          property        = "cycle_time_hours"
        }
        average_entities = null
        count_entities   = null
      }
      path_filter = [
        {
          from_blueprint = "githubPullRequest"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Weekly PR Cycle Time"
    }
    github_stale_prs_7d = {
      description = "Open PRs older than 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubPullRequest"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "status"
          value    = "open"
          }, {
          operator = "notBetween"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Stale PRs (7d+)"
    }
    github_workflow_runs_30d = {
      description = "Total workflow runs in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubWorkflowRun"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Monthly Workflow Runs"
    }
    github_workflow_runs_7d = {
      description = "Total workflow runs in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "githubWorkflowRun"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Weekly Workflow Runs"
    }
    total_deployments = {
      description = "Total successful deployments to Production"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = [
        {
          from_blueprint = "deployment"
          path           = ["service"]
        },
      ]
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "deploymentStatus"
          value    = "Success"
          }, {
          operator = "="
          property = "environment"
          value    = "Production"
        }]
      })
      target_blueprint_identifier = "deployment"
      title                       = "Total Deployments"
    }
  }
}

# __generated__ by Terraform from "_rule_result"
resource "port_system_blueprint" "_rule_result" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_rule_result"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "_ai_plan"
resource "port_system_blueprint" "_ai_plan" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_ai_plan"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "organizations"
resource "port_page" "organizations" {
  provider     = port-labs
  after        = "deployments"
  blueprint    = "organization"
  description  = null
  icon         = "Organization"
  identifier   = "organizations"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "Organizations"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"organization\",\"blueprintConfig\":{\"organization\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"organization-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "organization"
resource "port_blueprint" "organization" {
  provider = port-labs
  calculation_properties = {
    failure_rate_trend = {
      calculation = "((if (.properties.github_workflow_runs_30d != null and .properties.github_workflow_runs_30d != 0) then ((.properties.github_failed_workflow_runs_30d // 0) / .properties.github_workflow_runs_30d) * 100 | floor else 0 end) - (if (.properties.github_workflow_runs_7d != null and .properties.github_workflow_runs_7d != 0) then ((.properties.github_failed_workflow_runs_7d // 0) / .properties.github_workflow_runs_7d) * 100 | floor else 0 end)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly failure rate vs monthly average — Improving, Stable, or Degrading"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Workflow Failure Rate Trend"
      type                = "string"
    }
    github_cycle_time_trend = {
      calculation = "((.properties.github_pr_cycle_time // 0) - (.properties.github_pr_cycle_time_weekly // 0)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR cycle time — Improving, Stable, or Degrading"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "PR Cycle Time Trend"
      type                = "string"
    }
    github_merged_prs_per_service_last_month = {
      calculation         = "if (.properties.services_count != null and .properties.services_count != 0) then (.properties.github_merged_prs_last_month / .properties.services_count) else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "PRs merged in the last 30 days divided by number of services in the organization"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Monthly PR Throughput per Service"
      type                = "number"
    }
    github_stale_pr_share_percent = {
      calculation         = "if (.properties.github_open_prs != null and .properties.github_open_prs != 0) then (.properties.github_stale_prs_7d / .properties.github_open_prs) * 100 else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of open PRs that are older than 7 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Stale PR Share (%)"
      type                = "number"
    }
    github_throughput_trend = {
      calculation = "((.properties.github_merged_prs_last_week // 0) * 30 - (.properties.github_merged_prs_last_month // 0) * 7) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR throughput rate — Improving, Stable, or Degrading"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "PR Throughput Trend"
      type                = "string"
    }
    monthly_workflow_failure_rate = {
      calculation         = "if (.properties.github_workflow_runs_30d != null and .properties.github_workflow_runs_30d != 0) then ((.properties.github_failed_workflow_runs_30d // 0) / .properties.github_workflow_runs_30d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 30 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Monthly Workflow Failure Rate (%)"
      type                = "number"
    }
    weekly_workflow_failure_rate = {
      calculation         = "if (.properties.github_workflow_runs_7d != null and .properties.github_workflow_runs_7d != 0) then ((.properties.github_failed_workflow_runs_7d // 0) / .properties.github_workflow_runs_7d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 7 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Weekly Workflow Failure Rate (%)"
      type                = "number"
    }
  }
  create_catalog_page           = true
  description                   = "A logical organization grouping teams and services"
  force_delete_entities         = false
  icon                          = "Organization"
  identifier                    = "organization"
  include_in_global_search      = null
  kafka_changelog_destination   = null
  mirror_properties             = null
  ownership                     = null
  properties                    = null
  relations                     = null
  title                         = "Organization"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "services"
resource "port_page" "services" {
  provider     = port-labs
  after        = null
  blueprint    = "service"
  description  = "Register services manually by clicking \" + Service \""
  icon         = "Microservice"
  identifier   = "services"
  locked       = null
  page_filters = null
  parent       = "manage_service_catalog"
  title        = "Services"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"service\",\"blueprintConfig\":{\"service\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[\"$icon\",\"$title\",\"$team\",\"scorecardsStats\",\"production_readiness\",\"delivery_performance\",\"reliability_health\",\"github_last_push\",\"gitlab_last_activity\",\"ado_last_activity\"],\"shown\":[\"$title\",\"github_last_push\",\"gitlab_last_activity\",\"ado_last_activity\",\"production_readiness\",\"delivery_performance\",\"reliability_health\",\"scorecardsStats\",\"$team\"]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"service-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "_onboard_existing_team"
resource "port_action" "_onboard_existing_team" {
  provider                      = port-labs
  allow_anyone_to_view_runs     = null
  approval_email_notification   = null
  approval_webhook_notification = null
  automation_trigger            = null
  azure_method                  = null
  description                   = "Add members to an existing team"
  github_method                 = null
  gitlab_method                 = null
  icon                          = "Team"
  identifier                    = "_onboard_existing_team"
  integration_method            = null
  kafka_method                  = null
  publish                       = true
  required_approval             = "false"
  self_service_trigger = {
    action_card_button_text    = null
    blueprint_identifier       = "_team"
    condition                  = null
    execute_action_button_text = null
    operation                  = "DAY-2"
    order_properties           = null
    required_jq_query          = null
    steps                      = null
    titles                     = null
    user_properties = {
      array_props = {
        team_members = {
          boolean_items      = null
          default_jq_query   = null
          depends_on         = null
          description        = null
          disabled           = null
          disabled_jq_query  = null
          icon               = null
          max_items          = null
          max_items_jq_query = null
          min_items          = null
          min_items_jq_query = null
          number_items       = null
          object_items       = null
          required           = null
          sort = {
            order    = "DESC"
            property = "$title"
          }
          string_items = {
            blueprint     = "_user"
            dataset       = null
            default       = null
            enum          = null
            enum_jq_query = null
            format        = "entity"
          }
          title            = "Team members"
          visible          = null
          visible_jq_query = null
        }
      }
      boolean_props = null
      number_props  = null
      object_props  = null
      string_props  = null
    }
  }
  title                = "Add team members "
  upsert_entity_method = null
  webhook_method = {
    agent = "false"
    body = jsonencode({
      mapping = {
        blueprint = "_user"
        entity = {
          identifier = ".identifier"
          team       = ".team + [\"{{ .entity.identifier }}\"] | unique"
        }
        filter = ".identifier as $item | {{ .inputs.team_members | map(.identifier) }}  | any(. == $item)"
      }
      sourceBlueprint = "_user"
    })
    headers      = {}
    method       = "POST"
    synchronized = "true"
    url          = "https://api.us.getport.io/v1/migrations"
  }
}

# __generated__ by Terraform from "_mcp_server"
resource "port_system_blueprint" "_mcp_server" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_mcp_server"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "service:delivery_performance"
resource "port_scorecard" "delivery_performance" {
  provider   = port-labs
  blueprint  = "service"
  filter     = null
  identifier = "delivery_performance"
  levels     = null
  rules = [
    {
      description = null
      identifier  = "github_cycle_time_under_7d"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_pr_cycle_time\",\"value\":168}"]
      }
      title = "MR cycle time < 7 days"
    },
    {
      description = null
      identifier  = "github_cycle_time_not_degrading"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"!=\",\"property\":\"github_cycle_time_trend\",\"value\":\"Degrading\"}"]
      }
      title = "PR cycle time not degrading"
    },
    {
      description = null
      identifier  = "github_cycle_time_under_24h"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_pr_cycle_time\",\"value\":24}"]
      }
      title = "PR cycle time < 24h"
    },
    {
      description = null
      identifier  = "github_manageable_open_prs"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_open_prs\",\"value\":8}"]
      }
      title = "Open PRs ≤ 8"
    },
    {
      description = null
      identifier  = "github_good_open_pr_management"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_open_prs\",\"value\":5}"]
      }
      title = "Open PRs ≤ 5"
    },
    {
      description = null
      identifier  = "github_no_stale_prs"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"=\",\"property\":\"github_stale_prs_7d\",\"value\":0}"]
      }
      title = "Stale PRs = 0"
    },
    {
      description = null
      identifier  = "github_low_stale_prs"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_stale_pr_share_percent\",\"value\":10}"]
      }
      title = "Stale PR share ≤ 10%"
    },
    {
      description = null
      identifier  = "github_throughput_not_degrading"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"!=\",\"property\":\"github_throughput_trend\",\"value\":\"Degrading\"}"]
      }
      title = "Throughput not degrading"
    },
    {
      description = null
      identifier  = "github_has_merged_prs"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"github_merged_prs_last_month\",\"value\":8}"]
      }
      title = "Merged PRs ≥ 2/week"
    },
    {
      description = null
      identifier  = "github_minimal_stale_prs"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_stale_prs_7d\",\"value\":1}"]
      }
      title = "Stale PRs ≤ 1"
    },
    {
      description = null
      identifier  = "github_excellent_open_pr_management"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_open_prs\",\"value\":3}"]
      }
      title = "Open PRs ≤ 3"
    },
    {
      description = null
      identifier  = "github_good_throughput"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"github_merged_prs_last_month\",\"value\":20}"]
      }
      title = "Merged PRs ≥ 5/week"
    },
    {
      description = null
      identifier  = "github_excellent_throughput"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"github_merged_prs_last_month\",\"value\":40}"]
      }
      title = "Merged PRs ≥ 10/week"
    },
    {
      description = null
      identifier  = "github_cycle_time_under_1h"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_pr_cycle_time\",\"value\":1}"]
      }
      title = "PR cycle time < 1h"
    },
  ]
  title = "Delivery Performance"
}

# __generated__ by Terraform from "service:dora_lead_time"
resource "port_scorecard" "dora_lead_time" {
  provider   = port-labs
  blueprint  = "service"
  filter     = null
  identifier = "dora_lead_time"
  levels     = null
  rules = [
    {
      description = "DORA High tier"
      identifier  = "github_svc_lt_high"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_lead_time_for_change\",\"value\":168}"]
      }
      title = "Lead time under 1 week (< 168h)"
    },
    {
      description = "DORA Elite tier"
      identifier  = "github_svc_lt_elite"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_lead_time_for_change\",\"value\":24}"]
      }
      title = "Lead time under 1 day (< 24h)"
    },
    {
      description = "DORA Medium tier"
      identifier  = "github_svc_lt_medium"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_lead_time_for_change\",\"value\":720}"]
      }
      title = "Lead time under 1 month (< 720h)"
    },
  ]
  title = "Lead Time for Changes"
}

# __generated__ by Terraform from "githubUsers"
resource "port_page" "githubUsers" {
  provider     = port-labs
  after        = "githubPullRequests"
  blueprint    = "githubUser"
  description  = null
  icon         = "Github"
  identifier   = "githubUsers"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "GitHub Users"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"githubUser\",\"blueprintConfig\":{\"githubUser\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"githubUser-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "_ai_conversation"
resource "port_system_blueprint" "_ai_conversation" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_ai_conversation"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "githubOrganization"
resource "port_blueprint" "githubOrganization" {
  provider                    = port-labs
  calculation_properties      = null
  create_catalog_page         = true
  description                 = "This blueprint represents a GitHub organization with engineering metrics"
  force_delete_entities       = false
  icon                        = "Github"
  identifier                  = "githubOrganization"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties           = null
  ownership                   = null
  properties = {
    array_props   = null
    boolean_props = null
    number_props = {
      id = {
        default     = null
        description = "GitHub organization ID"
        enum        = null
        enum_colors = null
        icon        = null
        maximum     = null
        minimum     = null
        required    = false
        title       = "Organization ID"
      }
      publicRepos = {
        default     = null
        description = "Number of public repositories"
        enum        = null
        enum_colors = null
        icon        = null
        maximum     = null
        minimum     = null
        required    = false
        title       = "Public Repositories"
      }
    }
    object_props = null
    string_props = {
      avatarUrl = {
        date_format         = null
        default             = null
        description         = "Organization avatar image URL"
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Avatar URL"
      }
      createdAt = {
        date_format         = null
        default             = null
        description         = "When the organization was created"
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Created At"
      }
      description = {
        date_format         = null
        default             = null
        description         = "Organization description"
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Description"
      }
      login = {
        date_format         = null
        default             = null
        description         = "The GitHub organization login name"
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Organization Login"
      }
      nodeId = {
        date_format         = null
        default             = null
        description         = "GitHub GraphQL node ID"
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Node ID"
      }
      updatedAt = {
        date_format         = null
        default             = null
        description         = "When the organization was last updated"
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Updated At"
      }
      url = {
        date_format         = null
        default             = null
        description         = "GitHub organization page URL"
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "URL"
      }
    }
  }
  relations = {
    organization = {
      description = null
      many        = false
      required    = false
      target      = "organization"
      title       = "Organization"
    }
  }
  title                         = "GitHub Organization"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "workload"
resource "port_blueprint" "workload" {
  provider                    = port-labs
  calculation_properties      = null
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Deployment"
  identifier                  = "workload"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties           = null
  ownership = {
    path  = "service"
    title = null
    type  = "Inherited"
  }
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      version = {
        date_format         = null
        default             = null
        description         = "The version of the running service in this environment"
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Version"
      }
    }
  }
  relations = {
    environment = {
      description = null
      many        = false
      required    = false
      target      = "environment"
      title       = "Environment"
    }
    service = {
      description = null
      many        = false
      required    = false
      target      = "service"
      title       = "Service"
    }
  }
  title                         = "Workload"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "service:production_readiness"
resource "port_scorecard" "production_readiness" {
  provider   = port-labs
  blueprint  = "service"
  filter     = null
  identifier = "production_readiness"
  levels     = null
  rules = [
    {
      description = null
      identifier  = "github_has_criticality"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"criticality\"}"]
      }
      title = "Has criticality defined"
    },
    {
      description = null
      identifier  = "github_has_codeowners"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"github_codeowners\"}"]
      }
      title = "Has CODEOWNERS"
    },
    {
      description = null
      identifier  = "github_has_gitignore"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"github_gitignore\"}"]
      }
      title = "Has .gitignore"
    },
    {
      description = null
      identifier  = "github_has_url"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"github_url\"}"]
      }
      title = "Has repository URL"
    },
    {
      description = null
      identifier  = "github_has_pr_template"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"github_pr_template\"}"]
      }
      title = "Has PR template"
    },
    {
      description = null
      identifier  = "github_private_visibility"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"=\",\"property\":\"github_visibility\",\"value\":\"private\"}"]
      }
      title = "Private repository visibility"
    },
    {
      description = "Service must have a dedicated owning team — default team does not count"
      identifier  = "github_has_team"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"$team\"}", "{\"operator\":\"doesNotContains\",\"property\":\"$team\",\"value\":\"default-team\"}", "{\"operator\":\"doesNotContains\",\"property\":\"$team\",\"value\":\"default_team\"}"]
      }
      title = "Has team assigned"
    },
    {
      description = null
      identifier  = "github_has_language"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"github_language\"}"]
      }
      title = "Has language defined"
    },
    {
      description = null
      identifier  = "github_active_repo_7d"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_days_since_last_push\",\"value\":7}"]
      }
      title = "Active repo (pushed in last 7 days)"
    },
    {
      description = null
      identifier  = "github_active_repo_30d"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_days_since_last_push\",\"value\":30}"]
      }
      title = "Active repo (pushed in last 30 days)"
    },
    {
      description = null
      identifier  = "github_has_readme"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"isNotEmpty\",\"property\":\"github_readme\"}"]
      }
      title = "Has README"
    },
  ]
  title = "Production Readiness"
}

# __generated__ by Terraform from "githubWorkflowRun"
resource "port_blueprint" "githubWorkflowRun" {
  provider                    = port-labs
  calculation_properties      = null
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Github"
  identifier                  = "githubWorkflowRun"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties = {
    service_name = {
      path  = "service.$title"
      title = "Service Name"
    }
    workflow_current_result = {
      path  = "workflow.result"
      title = "Workflow Current Result"
    }
    workflow_name = {
      path  = "workflow.path"
      title = "Workflow Name"
    }
  }
  ownership = {
    path  = "service"
    title = "Owning Teams"
    type  = "Inherited"
  }
  properties = {
    array_props   = null
    boolean_props = null
    number_props = {
      runAttempt = {
        default     = null
        description = null
        enum        = null
        enum_colors = null
        icon        = null
        maximum     = null
        minimum     = null
        required    = false
        title       = "Run Attempt"
      }
      runNumber = {
        default     = null
        description = null
        enum        = null
        enum_colors = null
        icon        = null
        maximum     = null
        minimum     = null
        required    = false
        title       = "Run Number"
      }
    }
    object_props = null
    string_props = {
      conclusion = {
        date_format = null
        default     = null
        description = null
        enum        = ["success", "failure", "cancelled", "skipped", "timed_out", "action_required", "neutral", "stale", "startup_failure"]
        enum_colors = {
          action_required = "yellow"
          cancelled       = "lightGray"
          failure         = "red"
          neutral         = "lightGray"
          skipped         = "lightGray"
          stale           = "darkGray"
          startup_failure = "red"
          success         = "green"
          timed_out       = "orange"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Conclusion"
      }
      createdAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Created At"
      }
      headBranch = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Head Branch"
      }
      link = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "url"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Link"
      }
      name = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Name"
      }
      runStartedAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Run Started At"
      }
      status = {
        date_format = null
        default     = null
        description = null
        enum        = ["queued", "in_progress", "completed", "waiting", "requested", "pending"]
        enum_colors = {
          completed   = "green"
          in_progress = "blue"
          pending     = "yellow"
          queued      = "lightGray"
          requested   = "orange"
          waiting     = "yellow"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Status"
      }
      triggeringActor = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Triggering Actor"
      }
      updatedAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Updated At"
      }
    }
  }
  relations = {
    pullRequests = {
      description = null
      many        = true
      required    = false
      target      = "githubPullRequest"
      title       = "Pull Requests"
    }
    repository = {
      description = null
      many        = false
      required    = false
      target      = "githubRepository"
      title       = "Repository"
    }
    service = {
      description = null
      many        = false
      required    = false
      target      = "service"
      title       = "Service"
    }
    workflow = {
      description = null
      many        = false
      required    = false
      target      = "githubWorkflow"
      title       = "Workflow"
    }
  }
  title                         = "GitHub Workflow Run"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "_ai_agent"
resource "port_system_blueprint" "_ai_agent" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_ai_agent"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "githubOrganizations"
resource "port_page" "githubOrganizations" {
  provider     = port-labs
  after        = "githubRepositories"
  blueprint    = "githubOrganization"
  description  = null
  icon         = "Github"
  identifier   = "githubOrganizations"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "GitHub Organizations"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"githubOrganization\",\"blueprintConfig\":{\"githubOrganization\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"githubOrganization-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "githubRepositories"
resource "port_page" "githubRepositories" {
  provider     = port-labs
  after        = "githubTeams"
  blueprint    = "githubRepository"
  description  = null
  icon         = "Github"
  identifier   = "githubRepositories"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "GitHub Repositories"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"githubRepository\",\"blueprintConfig\":{\"githubRepository\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"githubRepository-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "_onboard_your_user"
resource "port_action" "_onboard_your_user" {
  provider                      = port-labs
  allow_anyone_to_view_runs     = null
  approval_email_notification   = null
  approval_webhook_notification = null
  automation_trigger            = null
  azure_method                  = null
  description                   = "Register your user and connect it to your user in other tools"
  github_method                 = null
  gitlab_method                 = null
  icon                          = "User"
  identifier                    = "_onboard_your_user"
  integration_method            = null
  kafka_method                  = null
  publish                       = true
  required_approval             = "false"
  self_service_trigger = {
    action_card_button_text    = null
    blueprint_identifier       = "_user"
    condition                  = null
    execute_action_button_text = null
    operation                  = "CREATE"
    order_properties           = ["teams"]
    required_jq_query          = null
    steps                      = null
    titles                     = null
    user_properties = {
      array_props = {
        teams = {
          boolean_items      = null
          default_jq_query   = ".user.teamsIdentifiers"
          depends_on         = null
          description        = null
          disabled           = null
          disabled_jq_query  = null
          icon               = "Team"
          max_items          = null
          max_items_jq_query = null
          min_items          = null
          min_items_jq_query = null
          number_items       = null
          object_items       = null
          required           = null
          sort               = null
          string_items = {
            blueprint     = "_team"
            dataset       = null
            default       = null
            enum          = null
            enum_jq_query = null
            format        = "entity"
          }
          title            = "Teams"
          visible          = true
          visible_jq_query = null
        }
      }
      boolean_props = null
      number_props  = null
      object_props  = null
      string_props = {
        your_user = {
          blueprint              = "_user"
          client_side_encryption = null
          dataset                = null
          default                = null
          default_jq_query       = ".user.email"
          depends_on             = null
          description            = null
          disabled               = null
          disabled_jq_query      = null
          encryption             = null
          enum                   = null
          enum_colors            = null
          enum_jq_query          = null
          format                 = "entity"
          icon                   = null
          max_length             = null
          min_length             = null
          pattern                = null
          pattern_jq_query       = null
          required               = null
          sort                   = null
          title                  = "Your user"
          visible                = false
          visible_jq_query       = null
        }
      }
    }
  }
  title = "Register your user"
  upsert_entity_method = {
    blueprint_identifier = "_user"
    mapping = {
      icon       = "DefaultBlueprint"
      identifier = "{{.trigger.by.user.email}}"
      properties = jsonencode({})
      relations  = null
      teams      = null
      teams_jq   = "{{.inputs.teams | (if . then map(.identifier) else [] end)}}"
    }
    title = null
  }
  webhook_method = null
}

# __generated__ by Terraform from "service"
resource "port_blueprint" "service" {
  provider = port-labs
  calculation_properties = {
    deploy_freq_tier = {
      calculation = "if (.properties.total_deployments == null or .properties.total_deployments == 0) then \"Low\" else if (.properties.deployment_frequency // 0) >= 7 then \"Elite\" elif (.properties.deployment_frequency // 0) >= 1 then \"High\" elif (.properties.deployment_frequency // 0) >= 0.25 then \"Medium\" else \"Low\" end end"
      colorized   = true
      colors = {
        Elite  = "lime"
        High   = "blue"
        Low    = "red"
        Medium = "orange"
      }
      date_format         = null
      description         = "DORA deployment frequency tier (from production deployments)"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Deployment Frequency"
      type                = "string"
    }
    github_cycle_time_trend = {
      calculation = "((.properties.github_pr_cycle_time // 0) - (.properties.github_pr_cycle_time_weekly // 0)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR cycle time"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "PR Cycle Time Trend"
      type                = "string"
    }
    github_days_since_last_push = {
      calculation         = "if .properties.github_last_push != null then ((now - (.properties.github_last_push[0:19] + \"Z\" | fromdateiso8601)) / 86400 | floor) else 9999 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Number of days since the last code push"
      format              = null
      icon                = "Clock"
      spec                = null
      spec_authentication = null
      title               = "Days Since Last Push"
      type                = "number"
    }
    github_failure_rate_trend = {
      calculation = "((if (.properties.github_workflow_runs_30d != null and .properties.github_workflow_runs_30d != 0) then ((.properties.github_failed_workflow_runs_30d // 0) / .properties.github_workflow_runs_30d) * 100 | floor else 0 end) - (if (.properties.github_workflow_runs_7d != null and .properties.github_workflow_runs_7d != 0) then ((.properties.github_failed_workflow_runs_7d // 0) / .properties.github_workflow_runs_7d) * 100 | floor else 0 end)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly failure rate vs monthly average"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Workflow Failure Rate Trend"
      type                = "string"
    }
    github_lead_time_tier = {
      calculation = "if (.properties.github_lead_time_for_change == null) then \"Low\" elif .properties.github_lead_time_for_change <= 24 then \"Elite\" elif .properties.github_lead_time_for_change <= 168 then \"High\" elif .properties.github_lead_time_for_change <= 720 then \"Medium\" else \"Low\" end"
      colorized   = true
      colors = {
        Elite  = "lime"
        High   = "blue"
        Low    = "red"
        Medium = "orange"
      }
      date_format         = null
      description         = "DORA lead time for changes tier (from GitHub PR cycle time)"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Lead Time for Changes (GitHub)"
      type                = "string"
    }
    github_monthly_workflow_failure_rate = {
      calculation         = "if (.properties.github_workflow_runs_30d != null and .properties.github_workflow_runs_30d != 0) then ((.properties.github_failed_workflow_runs_30d // 0) / .properties.github_workflow_runs_30d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 30 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Monthly Workflow Failure Rate (%)"
      type                = "number"
    }
    github_stale_pr_share_percent = {
      calculation         = "if (.properties.github_open_prs != null and .properties.github_open_prs != 0) then (.properties.github_stale_prs_7d / .properties.github_open_prs) * 100 else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of open PRs that are older than 7 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Stale PR Share (%)"
      type                = "number"
    }
    github_throughput_trend = {
      calculation = "((.properties.github_merged_prs_last_week // 0) * 30 - (.properties.github_merged_prs_last_month // 0) * 7) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR throughput rate"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "PR Throughput Trend"
      type                = "string"
    }
    github_weekly_workflow_failure_rate = {
      calculation         = "if (.properties.github_workflow_runs_7d != null and .properties.github_workflow_runs_7d != 0) then ((.properties.github_failed_workflow_runs_7d // 0) / .properties.github_workflow_runs_7d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 7 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Weekly Workflow Failure Rate (%)"
      type                = "number"
    }
  }
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Microservice"
  identifier                  = "service"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties = {
    github_codeowners = {
      path  = "github_repository.codeowners"
      title = "Code Owners"
    }
    github_default_branch = {
      path  = "github_repository.defaultBranch"
      title = "Default Branch"
    }
    github_description = {
      path  = "github_repository.description"
      title = "Description"
    }
    github_gitignore = {
      path  = "github_repository.gitignore"
      title = "Git Ignore"
    }
    github_language = {
      path  = "github_repository.language"
      title = "Programming Language"
    }
    github_last_push = {
      path  = "github_repository.last_push"
      title = "Last Repository Push"
    }
    github_pr_template = {
      path  = "github_repository.pr_template"
      title = "PR Template"
    }
    github_readme = {
      path  = "github_repository.readme"
      title = "README"
    }
    github_repository_id = {
      path  = "github_repository.$identifier"
      title = "Repo ID"
    }
    github_url = {
      path  = "github_repository.url"
      title = "Repository URL"
    }
    github_visibility = {
      path  = "github_repository.visibility"
      title = "Visibility"
    }
  }
  ownership = {
    path  = null
    title = null
    type  = "Direct"
  }
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      criticality = {
        date_format = null
        default     = null
        description = "Service criticality level"
        enum        = ["low", "medium", "high", "critical"]
        enum_colors = {
          critical = "red"
          high     = "orange"
          low      = "turquoise"
          medium   = "yellow"
        }
        format              = null
        icon                = "Alert"
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Criticality"
      }
    }
  }
  relations = {
    github_repository = {
      description = null
      many        = false
      required    = false
      target      = "githubRepository"
      title       = "GitHub Repository"
    }
  }
  title                         = "Service"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "organization:org_reliability_health"
resource "port_scorecard" "org_reliability_health" {
  provider   = port-labs
  blueprint  = "organization"
  filter     = null
  identifier = "org_reliability_health"
  levels     = null
  rules = [
    {
      description = null
      identifier  = "github_failure_rate_under_5"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"monthly_workflow_failure_rate\",\"value\":5}"]
      }
      title = "Workflow failure rate < 5%"
    },
    {
      description = null
      identifier  = "github_failure_rate_not_degrading"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"!=\",\"property\":\"failure_rate_trend\",\"value\":\"Degrading\"}"]
      }
      title = "Workflow failure rate not degrading"
    },
    {
      description = null
      identifier  = "github_failure_rate_under_15"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"monthly_workflow_failure_rate\",\"value\":15}"]
      }
      title = "Workflow failure rate < 15%"
    },
    {
      description = null
      identifier  = "github_failure_rate_under_30"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"monthly_workflow_failure_rate\",\"value\":30}"]
      }
      title = "Workflow failure rate < 30%"
    },
  ]
  title = "Reliability Health"
}

# __generated__ by Terraform from "organization"
resource "port_aggregation_properties" "organization_aggregation_properties" {
  provider             = port-labs
  blueprint_identifier = "organization"
  properties = {
    github_failed_workflow_runs_30d = {
      description = "Workflow runs that ended in failure in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastMonth"
          }
          }, {
          operator = "="
          property = "conclusion"
          value    = "failure"
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Monthly Failed Workflow Runs"
    }
    github_failed_workflow_runs_7d = {
      description = "Workflow runs that ended in failure in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
          }, {
          operator = "="
          property = "conclusion"
          value    = "failure"
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Weekly Failed Workflow Runs"
    }
    github_merged_prs_last_month = {
      description = "Pull requests merged in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Monthly PR Throughput"
    }
    github_merged_prs_last_week = {
      description = "Pull requests merged in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Weekly PR Throughput"
    }
    github_open_prs = {
      description = "Open pull requests"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "status"
          value    = "open"
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Open PRs"
    }
    github_pr_cycle_time = {
      description = "Average time from PR creation to merge (last month)"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property = {
          average_of      = "total"
          measure_time_by = "$createdAt"
          property        = "cycle_time_hours"
        }
        average_entities = null
        count_entities   = null
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Monthly PR Cycle Time"
    }
    github_pr_cycle_time_weekly = {
      description = "Average time from PR creation to merge (last week)"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property = {
          average_of      = "total"
          measure_time_by = "$createdAt"
          property        = "cycle_time_hours"
        }
        average_entities = null
        count_entities   = null
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "mergedAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Weekly PR Cycle Time"
    }
    github_stale_prs_7d = {
      description = "Open PRs older than 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "="
          property = "status"
          value    = "open"
          }, {
          operator = "notBetween"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubPullRequest"
      title                       = "Stale PRs (7d+)"
    }
    github_workflow_runs_30d = {
      description = "Total workflow runs in the last 30 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastMonth"
          }
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Monthly Workflow Runs"
    }
    github_workflow_runs_7d = {
      description = "Total workflow runs in the last 7 days"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter = null
      query = jsonencode({
        combinator = "and"
        rules = [{
          operator = "between"
          property = "createdAt"
          value = {
            preset = "lastWeek"
          }
        }]
      })
      target_blueprint_identifier = "githubWorkflowRun"
      title                       = "Weekly Workflow Runs"
    }
    services_count = {
      description = "Total number of services in the organization"
      icon        = "DefaultProperty"
      method = {
        aggregate_by_property = null
        average_by_property   = null
        average_entities      = null
        count_entities        = true
      }
      path_filter                 = null
      query                       = null
      target_blueprint_identifier = "service"
      title                       = "Number of Services"
    }
  }
}

# __generated__ by Terraform from "githubTeams"
resource "port_page" "githubTeams" {
  provider     = port-labs
  after        = "githubWorkflowRuns"
  blueprint    = "githubTeam"
  description  = null
  icon         = "Github"
  identifier   = "githubTeams"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "GitHub Teams"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"githubTeam\",\"blueprintConfig\":{\"githubTeam\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"githubTeam-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "set_ownership"
resource "port_action" "set_ownership" {
  provider                      = port-labs
  allow_anyone_to_view_runs     = null
  approval_email_notification   = null
  approval_webhook_notification = null
  automation_trigger            = null
  azure_method                  = null
  description                   = "Assign service ownership to an existing team"
  github_method                 = null
  gitlab_method                 = null
  icon                          = "Microservice"
  identifier                    = "set_ownership"
  integration_method            = null
  kafka_method                  = null
  publish                       = true
  required_approval             = "false"
  self_service_trigger = {
    action_card_button_text    = null
    blueprint_identifier       = "_team"
    condition                  = null
    execute_action_button_text = null
    operation                  = "DAY-2"
    order_properties           = null
    required_jq_query          = null
    steps                      = null
    titles                     = null
    user_properties = {
      array_props = {
        services_owned_by_this_team = {
          boolean_items      = null
          default_jq_query   = null
          depends_on         = null
          description        = null
          disabled           = null
          disabled_jq_query  = null
          icon               = "DefaultProperty"
          max_items          = null
          max_items_jq_query = null
          min_items          = null
          min_items_jq_query = null
          number_items       = null
          object_items       = null
          required           = true
          sort               = null
          string_items = {
            blueprint     = "service"
            dataset       = null
            default       = null
            enum          = null
            enum_jq_query = null
            format        = "entity"
          }
          title            = "Services owned by this team"
          visible          = null
          visible_jq_query = null
        }
      }
      boolean_props = null
      number_props  = null
      object_props  = null
      string_props  = null
    }
  }
  title                = "Own services"
  upsert_entity_method = null
  webhook_method = {
    agent = "false"
    body = jsonencode({
      mapping = {
        blueprint = "service"
        entity = {
          identifier = ".identifier"
          team       = ".relations.owning_teams + [\"{{ .entity.identifier }}\"] | unique"
        }
        filter = ".identifier as $item | {{ .inputs.services_owned_by_this_team | map(.identifier) }} | any(. == $item)"
      }
      sourceBlueprint = "service"
    })
    headers = {
      RUN_ID = "{{ .run.id }}"
    }
    method       = "POST"
    synchronized = "true"
    url          = "https://api.us.getport.io/v1/migrations"
  }
}

# __generated__ by Terraform from "_scorecard"
resource "port_system_blueprint" "_scorecard" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_scorecard"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "organization:org_delivery_performance"
resource "port_scorecard" "org_delivery_performance" {
  provider   = port-labs
  blueprint  = "organization"
  filter     = null
  identifier = "org_delivery_performance"
  levels     = null
  rules = [
    {
      description = null
      identifier  = "github_cycle_time_under_1h"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_pr_cycle_time\",\"value\":1}"]
      }
      title = "Avg PR cycle time < 1h"
    },
    {
      description = null
      identifier  = "github_low_stale_prs"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c=\",\"property\":\"github_stale_pr_share_percent\",\"value\":10}"]
      }
      title = "Stale PR share ≤ 10%"
    },
    {
      description = null
      identifier  = "github_throughput_not_degrading"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"!=\",\"property\":\"github_throughput_trend\",\"value\":\"Degrading\"}"]
      }
      title = "Throughput not degrading"
    },
    {
      description = null
      identifier  = "github_cycle_time_under_7d"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_pr_cycle_time\",\"value\":168}"]
      }
      title = "Avg PR cycle time < 7 days"
    },
    {
      description = null
      identifier  = "github_good_throughput"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"github_merged_prs_per_service_last_month\",\"value\":20}"]
      }
      title = "Merged PRs ≥ 5/week per service"
    },
    {
      description = null
      identifier  = "github_cycle_time_under_24h"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_pr_cycle_time\",\"value\":24}"]
      }
      title = "Avg PR cycle time < 24h"
    },
    {
      description = null
      identifier  = "github_excellent_throughput"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"github_merged_prs_per_service_last_month\",\"value\":40}"]
      }
      title = "Merged PRs ≥ 10/week per service"
    },
    {
      description = null
      identifier  = "github_has_merged_prs"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e=\",\"property\":\"github_merged_prs_per_service_last_month\",\"value\":8}"]
      }
      title = "Merged PRs ≥ 2/week per service"
    },
    {
      description = null
      identifier  = "github_cycle_time_not_degrading"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"!=\",\"property\":\"github_cycle_time_trend\",\"value\":\"Degrading\"}"]
      }
      title = "PR cycle time not degrading"
    },
  ]
  title = "Delivery Performance"
}

# __generated__ by Terraform from "_ai_invocations"
resource "port_system_blueprint" "_ai_invocations" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_ai_invocations"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "_rule"
resource "port_system_blueprint" "_rule" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_rule"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}

# __generated__ by Terraform from "set_parent_team_relations"
resource "port_action" "set_parent_team_relations" {
  provider                      = port-labs
  allow_anyone_to_view_runs     = true
  approval_email_notification   = null
  approval_webhook_notification = null
  automation_trigger = {
    any_entity_change_event = {
      blueprint_identifier = "_team"
    }
    any_run_change_event = null
    entity_created_event = null
    entity_deleted_event = null
    entity_updated_event = null
    jq_condition = {
      combinator  = "and"
      expressions = [".diff.after != null", ".diff.after.properties.type != \"group\"", "(.diff.after.relations.parent_team == null) or (.diff.after.relations.parent_team == \"\")"]
    }
    run_created_event            = null
    run_updated_event            = null
    timer_property_expired_event = null
  }
  azure_method         = null
  description          = "Set relations between Teams and the \"default group\" when a Team without a parent team is updated"
  github_method        = null
  gitlab_method        = null
  icon                 = "Team"
  identifier           = "set_parent_team_relations"
  integration_method   = null
  kafka_method         = null
  publish              = true
  required_approval    = null
  self_service_trigger = null
  title                = "Set Parent Team relations"
  upsert_entity_method = {
    blueprint_identifier = "_team"
    mapping = {
      icon       = null
      identifier = "{{ .event.diff.after.identifier }}"
      properties = null
      relations = jsonencode({
        parent_team = "default_group"
      })
      teams    = null
      teams_jq = null
    }
    title = null
  }
  webhook_method = null
}

# __generated__ by Terraform from "githubWorkflow"
resource "port_blueprint" "githubWorkflow" {
  provider                    = port-labs
  calculation_properties      = null
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Github"
  identifier                  = "githubWorkflow"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties           = null
  ownership                   = null
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      createdAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Created At"
      }
      last_triggered_at = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Last Triggered At"
      }
      link = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "url"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Link"
      }
      path = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Path"
      }
      result = {
        date_format = null
        default     = null
        description = "Latest run conclusion (merged from workflow-run data)"
        enum        = ["success", "failure", "cancelled", "skipped", "timed_out", "action_required", "neutral", "stale", "startup_failure"]
        enum_colors = {
          action_required = "yellow"
          cancelled       = "lightGray"
          failure         = "red"
          neutral         = "lightGray"
          skipped         = "lightGray"
          stale           = "darkGray"
          startup_failure = "red"
          success         = "green"
          timed_out       = "orange"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Result"
      }
      status = {
        date_format = null
        default     = null
        description = null
        enum        = ["active", "deleted", "disabled_fork", "disabled_inactivity", "disabled_manually"]
        enum_colors = {
          active  = "green"
          deleted = "red"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Status"
      }
      updatedAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Updated At"
      }
    }
  }
  relations = {
    repository = {
      description = null
      many        = false
      required    = false
      target      = "githubRepository"
      title       = "Repository"
    }
  }
  title                         = "GitHub Workflow"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "githubPullRequest"
resource "port_blueprint" "githubPullRequest" {
  provider = port-labs
  calculation_properties = {
    days_old = {
      calculation         = "(now / 86400) - (.properties.createdAt | capture(\"(?<date>\\\\d{4}-\\\\d{2}-\\\\d{2})\") | .date | strptime(\"%Y-%m-%d\") | mktime / 86400) | floor"
      colorized           = null
      colors              = null
      date_format         = null
      description         = null
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Days Old"
      type                = "number"
    }
    is_stale = {
      calculation = "if (.properties.status == \"open\" and (((now / 86400) - (.properties.createdAt | capture(\"(?<date>\\\\d{4}-\\\\d{2}-\\\\d{2})\") | .date | strptime(\"%Y-%m-%d\") | mktime / 86400) | floor) > 7)) then true else false end"
      colorized   = true
      colors = {
        true = "orange"
      }
      date_format         = null
      description         = "True when this PR is open and older than 7 days"
      format              = null
      icon                = "Clock"
      spec                = null
      spec_authentication = null
      title               = "Is Stale (7d+)"
      type                = "boolean"
    }
    pr_age_label = {
      calculation = "((if .properties.mergedAt == null then (now / 86400) else (.properties.mergedAt | capture(\"(?<date>\\\\d{4}-\\\\d{2}-\\\\d{2})\") | .date | strptime(\"%Y-%m-%d\") | mktime / 86400) end) as $toDate | $toDate - (.properties.createdAt | capture(\"(?<date>\\\\d{4}-\\\\d{2}-\\\\d{2})\") | .date | strptime(\"%Y-%m-%d\") | mktime / 86400) | floor) as $daysOld | if $daysOld <= 3 then \"0-3 days\" elif $daysOld <= 7 then \"3-7 days\" elif $daysOld <= 30 then \"7-30 days\" else \">30 days\" end"
      colorized   = true
      colors = {
        "0-3 days"  = "green"
        "3-7 days"  = "yellow"
        "7-30 days" = "orange"
        ">30 days"  = "red"
      }
      date_format         = null
      description         = "Classifies a PR into 0-3 days | 3-7 days | 7-30 days | >30 days"
      format              = null
      icon                = "Clock"
      spec                = null
      spec_authentication = null
      title               = "PR Age"
      type                = "string"
    }
  }
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Github"
  identifier                  = "githubPullRequest"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties = {
    reviewer_teams = {
      path  = "reviewers.$team"
      title = "Reviewer Teams"
    }
  }
  ownership = {
    path  = "service"
    title = "Owning Teams"
    type  = "Inherited"
  }
  properties = {
    array_props = null
    boolean_props = {
      has_assignees = {
        default     = null
        description = null
        icon        = null
        required    = false
        title       = "Has assignees"
      }
      has_reviewers = {
        default     = null
        description = null
        icon        = null
        required    = false
        title       = "Has reviewers"
      }
    }
    number_props = {
      cycle_time_hours = {
        default     = null
        description = "Time from PR creation to merge in hours."
        enum        = null
        enum_colors = null
        icon        = null
        maximum     = null
        minimum     = null
        required    = false
        title       = "PR Cycle Time (Hours)"
      }
      lead_time_hours = {
        default     = null
        description = "DORA Lead Time for Changes — time from first commit to merge in hours. Falls back to PR creation if commit data unavailable."
        enum        = null
        enum_colors = null
        icon        = null
        maximum     = null
        minimum     = null
        required    = false
        title       = "Lead Time for Changes (Hours)"
      }
      prNumber = {
        default     = null
        description = null
        enum        = null
        enum_colors = null
        icon        = null
        maximum     = null
        minimum     = null
        required    = false
        title       = "PR Number"
      }
    }
    object_props = null
    string_props = {
      branch = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Branch"
      }
      closedAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Closed At"
      }
      createdAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Created At"
      }
      link = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "url"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Link"
      }
      mergedAt = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Merged At"
      }
      reviewDecision = {
        date_format = null
        default     = null
        description = "The review decision state of the pull request"
        enum        = ["APPROVED", "CHANGES_REQUESTED", "REVIEW_REQUIRED"]
        enum_colors = {
          APPROVED          = "green"
          CHANGES_REQUESTED = "orange"
          REVIEW_REQUIRED   = "yellow"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Review Decision"
      }
      status = {
        date_format = null
        default     = null
        description = null
        enum        = ["open", "closed", "merged"]
        enum_colors = {
          closed = "red"
          merged = "green"
          open   = "blue"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Status"
      }
    }
  }
  relations = {
    assignees = {
      description = null
      many        = true
      required    = false
      target      = "_user"
      title       = "Assignees"
    }
    creator = {
      description = null
      many        = false
      required    = false
      target      = "_user"
      title       = "Creator"
    }
    git_hub_assignees = {
      description = null
      many        = true
      required    = false
      target      = "githubUser"
      title       = "Assignees"
    }
    git_hub_creator = {
      description = null
      many        = false
      required    = false
      target      = "githubUser"
      title       = "Creator"
    }
    git_hub_reviewers = {
      description = null
      many        = true
      required    = false
      target      = "githubUser"
      title       = "Reviewers"
    }
    repository = {
      description = null
      many        = false
      required    = false
      target      = "githubRepository"
      title       = "Repository"
    }
    reviewers = {
      description = null
      many        = true
      required    = false
      target      = "_user"
      title       = "Reviewers"
    }
    service = {
      description = null
      many        = false
      required    = false
      target      = "service"
      title       = "Service"
    }
  }
  title                         = "GitHub Pull Request"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "environments"
resource "port_page" "environments" {
  provider     = port-labs
  after        = "workloads"
  blueprint    = "environment"
  description  = "Register environments manually by clicking \" + Environment \""
  icon         = "Environment"
  identifier   = "environments"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "Environments"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"environment\",\"blueprintConfig\":{\"environment\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"environment-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "deployments"
resource "port_page" "deployments" {
  provider     = port-labs
  after        = "githubUsers"
  blueprint    = "deployment"
  description  = null
  icon         = "Deployment"
  identifier   = "deployments"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "Deployments"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"deployment\",\"blueprintConfig\":{\"deployment\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"deployment-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "githubWorkflowRuns"
resource "port_page" "githubWorkflowRuns" {
  provider     = port-labs
  after        = null
  blueprint    = "githubWorkflowRun"
  description  = null
  icon         = "Github"
  identifier   = "githubWorkflowRuns"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "GitHub Workflow Runs"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"githubWorkflowRun\",\"blueprintConfig\":{\"githubWorkflowRun\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"githubWorkflowRun-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "githubRepository"
resource "port_blueprint" "githubRepository" {
  provider = port-labs
  calculation_properties = {
    cycle_time_trend = {
      calculation = "((.properties.pr_cycle_time // 0) - (.properties.pr_cycle_time_weekly // 0)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR cycle time — Improving, Stable, or Degrading"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "PR Cycle Time Trend"
      type                = "string"
    }
    failure_rate_trend = {
      calculation = "((if (.properties.workflow_runs_30d != null and .properties.workflow_runs_30d != 0) then ((.properties.failed_workflow_runs_30d // 0) / .properties.workflow_runs_30d) * 100 | floor else 0 end) - (if (.properties.workflow_runs_7d != null and .properties.workflow_runs_7d != 0) then ((.properties.failed_workflow_runs_7d // 0) / .properties.workflow_runs_7d) * 100 | floor else 0 end)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly failure rate vs monthly average — Improving, Stable, or Degrading"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Workflow Failure Rate Trend"
      type                = "string"
    }
    monthly_workflow_failure_rate = {
      calculation         = "if (.properties.workflow_runs_30d != null and .properties.workflow_runs_30d != 0) then ((.properties.failed_workflow_runs_30d // 0) / .properties.workflow_runs_30d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 30 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Monthly Workflow Failure Rate (%)"
      type                = "number"
    }
    stale_pr_share_percent = {
      calculation         = "if (.properties.open_prs != null and .properties.open_prs != 0) then (.properties.stale_prs_7d / .properties.open_prs) * 100 else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of open PRs that are older than 7 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Stale PR Share (%)"
      type                = "number"
    }
    throughput_trend = {
      calculation = "((.properties.merged_prs_last_week // 0) * 30 - (.properties.merged_prs_last_month // 0) * 7) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR throughput rate — Improving, Stable, or Degrading"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "PR Throughput Trend"
      type                = "string"
    }
    weekly_workflow_failure_rate = {
      calculation         = "if (.properties.workflow_runs_7d != null and .properties.workflow_runs_7d != 0) then ((.properties.failed_workflow_runs_7d // 0) / .properties.workflow_runs_7d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 7 days"
      format              = null
      icon                = "DefaultProperty"
      spec                = null
      spec_authentication = null
      title               = "Weekly Workflow Failure Rate (%)"
      type                = "number"
    }
  }
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Github"
  identifier                  = "githubRepository"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties           = null
  ownership = {
    path  = null
    title = null
    type  = "Direct"
  }
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      codeowners = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "markdown"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "CODEOWNERS"
      }
      defaultBranch = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Default branch"
      }
      description = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Description"
      }
      gitignore = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Git Ignore"
      }
      language = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Language"
      }
      last_push = {
        date_format         = null
        default             = null
        description         = "Last commit to the main branch"
        enum                = null
        enum_colors         = null
        format              = "date-time"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Last Repository Push"
      }
      pr_template = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "PR Template"
      }
      readme = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "markdown"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "README"
      }
      url = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "url"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Repository URL"
      }
      visibility = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Visibility"
      }
    }
  }
  relations = {
    githubTeams = {
      description = null
      many        = true
      required    = false
      target      = "githubTeam"
      title       = "GitHub Teams"
    }
  }
  title                         = "GitHub Repository"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "githubPullRequests"
resource "port_page" "githubPullRequests" {
  provider     = port-labs
  after        = "githubWorkflows"
  blueprint    = "githubPullRequest"
  description  = null
  icon         = "Github"
  identifier   = "githubPullRequests"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "GitHub Pull Requests"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"githubPullRequest\",\"blueprintConfig\":{\"githubPullRequest\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"githubPullRequest-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "githubWorkflows"
resource "port_page" "githubWorkflows" {
  provider     = port-labs
  after        = "githubOrganizations"
  blueprint    = "githubWorkflow"
  description  = null
  icon         = "Github"
  identifier   = "githubWorkflows"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "GitHub Workflows"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"githubWorkflow\",\"blueprintConfig\":{\"githubWorkflow\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"githubWorkflow-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "githubTeam"
resource "port_blueprint" "githubTeam" {
  provider                    = port-labs
  calculation_properties      = null
  create_catalog_page         = true
  description                 = null
  force_delete_entities       = false
  icon                        = "Github"
  identifier                  = "githubTeam"
  include_in_global_search    = null
  kafka_changelog_destination = null
  mirror_properties           = null
  ownership                   = null
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      description = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Description"
      }
      link = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = "url"
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Link"
      }
      notification_setting = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Notification Setting"
      }
      slug = {
        date_format         = null
        default             = null
        description         = null
        enum                = null
        enum_colors         = null
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Slug"
      }
    }
  }
  relations = {
    organization = {
      description = null
      many        = false
      required    = false
      target      = "githubOrganization"
      title       = "Organization"
    }
  }
  title                         = "GitHub Team"
  webhook_changelog_destination = null
}

# __generated__ by Terraform from "_user"
resource "port_system_blueprint" "_user" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_user"
  include_in_global_search = null
  mirror_properties = {
    git_hub_username = {
      path  = "git_hub_user.$identifier"
      title = "GitHub username"
    }
  }
  properties = null
  relations = {
    git_hub_user = {
      description = null
      many        = false
      required    = false
      target      = "githubUser"
      title       = "GitHub User"
    }
  }
}

# __generated__ by Terraform from "_team"
resource "port_system_blueprint" "_team" {
  provider = port-labs
  calculation_properties = {
    deploy_freq_tier = {
      calculation = "if (.properties.total_deployments == null or .properties.total_deployments == 0) then \"Low\" else (if (.properties.services_count != null and .properties.services_count != 0) then ((.properties.deployment_frequency // 0) / .properties.services_count) else 0 end) as $dpf | if $dpf >= 7 then \"Elite\" elif $dpf >= 1 then \"High\" elif $dpf >= 0.25 then \"Medium\" else \"Low\" end end"
      colorized   = true
      colors = {
        Elite  = "lime"
        High   = "blue"
        Low    = "red"
        Medium = "orange"
      }
      date_format         = null
      description         = "DORA deployment frequency tier (per service)"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Deployment Frequency"
      type                = "string"
    }
    deployment_frequency_per_service = {
      calculation         = "if (.properties.total_deployments == null or .properties.total_deployments == 0) then null elif (.properties.services_count != null and .properties.services_count != 0) then (.properties.deployment_frequency // 0) / .properties.services_count else null end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Average successful deployments per service per week"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Deployment Frequency per Service (per week)"
      type                = "number"
    }
    failure_rate_trend = {
      calculation = "((if (.properties.github_workflow_runs_30d != null and .properties.github_workflow_runs_30d != 0) then ((.properties.github_failed_workflow_runs_30d // 0) / .properties.github_workflow_runs_30d) * 100 | floor else 0 end) - (if (.properties.github_workflow_runs_7d != null and .properties.github_workflow_runs_7d != 0) then ((.properties.github_failed_workflow_runs_7d // 0) / .properties.github_workflow_runs_7d) * 100 | floor else 0 end)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly failure rate vs monthly average — Improving, Stable, or Degrading"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Workflow Failure Rate Trend"
      type                = "string"
    }
    github_cycle_time_trend = {
      calculation = "((.properties.github_pr_cycle_time // 0) - (.properties.github_pr_cycle_time_weekly // 0)) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR cycle time — Improving, Stable, or Degrading"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "PR Cycle Time Trend"
      type                = "string"
    }
    github_lead_time_tier = {
      calculation = "if (.properties.github_lead_time_for_change == null) then \"Low\" elif .properties.github_lead_time_for_change <= 24 then \"Elite\" elif .properties.github_lead_time_for_change <= 168 then \"High\" elif .properties.github_lead_time_for_change <= 720 then \"Medium\" else \"Low\" end"
      colorized   = true
      colors = {
        Elite  = "lime"
        High   = "blue"
        Low    = "red"
        Medium = "orange"
      }
      date_format         = null
      description         = "DORA lead time for changes tier"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Lead Time for Changes"
      type                = "string"
    }
    github_merged_prs_per_service_last_month = {
      calculation         = "if (.properties.services_count != null and .properties.services_count != 0) then (.properties.github_merged_prs_last_month / .properties.services_count) else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "PRs merged in the last 30 days divided by number of services"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Monthly PR Throughput per Service"
      type                = "number"
    }
    github_open_prs_per_service = {
      calculation         = "if (.properties.services_count != null and .properties.services_count != 0) then (.properties.github_open_prs / .properties.services_count) else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Open PR count divided by number of services owned by the team"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Open PRs per Service"
      type                = "number"
    }
    github_stale_pr_share_percent = {
      calculation         = "if (.properties.github_open_prs != null and .properties.github_open_prs != 0) then (.properties.github_stale_prs_7d / .properties.github_open_prs) * 100 else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of open PRs that are older than 7 days"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Stale PR Share (%)"
      type                = "number"
    }
    github_stale_prs_per_service_7d = {
      calculation         = "if (.properties.services_count != null and .properties.services_count != 0) then (.properties.github_stale_prs_7d / .properties.services_count) else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Open PRs older than 7 days divided by number of services"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Stale PRs per Service"
      type                = "number"
    }
    github_throughput_trend = {
      calculation = "((.properties.github_merged_prs_last_week // 0) * 30 - (.properties.github_merged_prs_last_month // 0) * 7) as $diff | if $diff > 0 then \"Improving\" elif $diff < 0 then \"Degrading\" else \"Stable\" end"
      colorized   = true
      colors = {
        Degrading = "red"
        Improving = "green"
        Stable    = "blue"
      }
      date_format         = null
      description         = "Weekly vs monthly PR throughput rate — Improving, Stable, or Degrading"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "PR Throughput Trend"
      type                = "string"
    }
    monthly_workflow_failure_rate = {
      calculation         = "if (.properties.github_workflow_runs_30d != null and .properties.github_workflow_runs_30d != 0) then ((.properties.github_failed_workflow_runs_30d // 0) / .properties.github_workflow_runs_30d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 30 days"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Monthly Workflow Failure Rate (%)"
      type                = "number"
    }
    weekly_workflow_failure_rate = {
      calculation         = "if (.properties.github_workflow_runs_7d != null and .properties.github_workflow_runs_7d != 0) then ((.properties.github_failed_workflow_runs_7d // 0) / .properties.github_workflow_runs_7d) * 100 | floor else 0 end"
      colorized           = null
      colors              = null
      date_format         = null
      description         = "Percentage of workflow runs that failed in the last 7 days"
      format              = null
      icon                = null
      spec                = null
      spec_authentication = null
      title               = "Weekly Workflow Failure Rate (%)"
      type                = "number"
    }
  }
  identifier               = "_team"
  include_in_global_search = null
  mirror_properties = {
    parent_team_name = {
      path  = "parent_team.$title"
      title = "Parent Team"
    }
  }
  properties = {
    array_props   = null
    boolean_props = null
    number_props  = null
    object_props  = null
    string_props = {
      type = {
        date_format = null
        default     = "team"
        description = "Hierarchy level — team (leaf) or group (intermediate)"
        enum        = ["team", "group"]
        enum_colors = {
          group = "turquoise"
          team  = "blue"
        }
        format              = null
        icon                = null
        max_length          = null
        min_length          = null
        pattern             = null
        required            = false
        spec                = null
        spec_authentication = null
        title               = "Type"
      }
    }
  }
  relations = {
    organization = {
      description = null
      many        = false
      required    = false
      target      = "organization"
      title       = "Organization"
    }
    parent_team = {
      description = null
      many        = false
      required    = false
      target      = "_team"
      title       = "Parent Team"
    }
  }
}

# __generated__ by Terraform from "service:reliability_health"
resource "port_scorecard" "reliability_health" {
  provider   = port-labs
  blueprint  = "service"
  filter     = null
  identifier = "reliability_health"
  levels     = null
  rules = [
    {
      description = null
      identifier  = "github_failure_rate_not_degrading"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"!=\",\"property\":\"github_failure_rate_trend\",\"value\":\"Degrading\"}"]
      }
      title = "Workflow failure rate not degrading"
    },
    {
      description = null
      identifier  = "github_failure_rate_under_5"
      level       = "Gold"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_monthly_workflow_failure_rate\",\"value\":5}"]
      }
      title = "Workflow failure rate < 5%"
    },
    {
      description = null
      identifier  = "github_has_workflow_runs"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003e\",\"property\":\"github_workflow_runs_30d\",\"value\":0}"]
      }
      title = "Has workflow runs this month"
    },
    {
      description = null
      identifier  = "github_failure_rate_under_30"
      level       = "Bronze"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_monthly_workflow_failure_rate\",\"value\":30}"]
      }
      title = "Workflow failure rate < 30%"
    },
    {
      description = null
      identifier  = "github_failure_rate_under_15"
      level       = "Silver"
      query = {
        combinator = "and"
        conditions = ["{\"operator\":\"\\u003c\",\"property\":\"github_monthly_workflow_failure_rate\",\"value\":15}"]
      }
      title = "Workflow failure rate < 15%"
    },
  ]
  title = "Reliability Health"
}

# __generated__ by Terraform from "workloads"
resource "port_page" "workloads" {
  provider     = port-labs
  after        = "organizations"
  blueprint    = "workload"
  description  = "Register workloads manually by clicking \" + Workload \""
  icon         = "Deployment"
  identifier   = "workloads"
  locked       = null
  page_filters = null
  parent       = "catalog_tables"
  title        = "Workloads"
  type         = "blueprint-entities"
  widgets      = ["{\"blueprint\":\"workload\",\"blueprintConfig\":{\"workload\":{\"groupSettings\":{\"groupBy\":[]},\"propertiesSettings\":{\"order\":[]}}},\"dataset\":{\"combinator\":\"and\",\"rules\":[]},\"id\":\"workload-explorer\",\"type\":\"table-entities-explorer\"}"]
}

# __generated__ by Terraform from "_workflow"
resource "port_system_blueprint" "_workflow" {
  provider                 = port-labs
  calculation_properties   = null
  identifier               = "_workflow"
  include_in_global_search = null
  mirror_properties        = null
  properties               = null
  relations                = null
}
