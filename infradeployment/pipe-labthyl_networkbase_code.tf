
######################################################
############## labthyl_networkbase_code ##############
######################################################


############## DEV ##############
resource "aws_codepipeline" "cicd_pipeline_dev" {

  name     = "labthyl_networkbase_code_dev"
  role_arn = aws_iam_role.tf-codepipeline-role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_artifacts.id
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["tf-code"]
      configuration = {
        FullRepositoryId     = "thieslei/labthyl_networkbase_code"
        BranchName           = "develop"
        ConnectionArn        = var.connector_credentials
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Plan_dev"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-plan-dev"
      }
    }
  }

  stage {
    name = "Apply_dev"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-apply-dev"
      }
    }
  }
}


############## STG ##############
resource "aws_codepipeline" "cicd_pipeline_stg" {

  name     = "labthyl_networkbase_code_stg"
  role_arn = aws_iam_role.tf-codepipeline-role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_artifacts.id
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["tf-code"]
      configuration = {
        FullRepositoryId     = "thieslei/labthyl_networkbase_code"
        BranchName           = "release"
        ConnectionArn        = var.connector_credentials
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }
  stage {
    name = "Approval"
    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }
  stage {
    name = "Plan_stg"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-plan-stg"
      }
    }
  }

  stage {
    name = "Apply_stg"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-apply-stg"
      }
    }
  }
}

############## PRD ##############
resource "aws_codepipeline" "cicd_pipeline_prd" {

  name     = "labthyl_networkbase_code_prd"
  role_arn = aws_iam_role.tf-codepipeline-role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_artifacts.id
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["tf-code"]
      configuration = {
        FullRepositoryId     = "thieslei/labthyl_networkbase_code"
        BranchName           = "main"
        ConnectionArn        = var.connector_credentials
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }
  stage {
    name = "Approval"
    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }
  stage {
    name = "Plan_prd"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-plan-prd"
      }
    }
  }

  stage {
    name = "Apply_prd"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-apply-prd"
      }
    }
  }
}

#    stage {
#    name = "Approve"
#
#   action {
#       name     = "Approval"
#       category = "Approval"
#       owner    = "AWS"
#       provider = "Manual"
#       version  = "1"
#
#      # configuration {
#      # NotificationArn = "${var.approve_sns_arn}"
#      # CustomData = "${var.approve_comment}"
#      # ExternalEntityLink = "${var.approve_url}"
#       #}
#   }
#   }
#   
#   stage {
#       name ="Destroy"
#       action{
#           name = "Destroy"
#           category = "Build"
#           provider = "CodeBuild"
#           version = "1"
#           owner = "AWS"
#           
#           input_artifacts = ["tf-code"]
#           configuration = {
#               ProjectName = "tf-cicd-destroy"
#           }
#       }
#   }
