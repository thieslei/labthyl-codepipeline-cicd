
######################################################
############## labthyl_networkbase_code ##############
######################################################

resource "aws_codepipeline" "cicd_pipeline" {

  name     = "labthyl_networkbase_code"
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
    name = "Plan"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-plan"
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-apply"
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

}