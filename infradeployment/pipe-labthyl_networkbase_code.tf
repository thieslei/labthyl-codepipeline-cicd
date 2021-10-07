
######################################################
############## labthyl_networkbase_code ##############
######################################################


############## DEV ##############
resource "aws_codepipeline" "cicd_pipeline_dev" {

  name     = "labthyl_networkbase_code_DEV"
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
    name = "Plan DEV"
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
    name = "Apply DEV"
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
resource "aws_codepipeline" "cicd_pipeline_STG" {

  name     = "labthyl_networkbase_code_STG"
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
    name = "Plan STG"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-plan-STG"
      }
    }
  }

  stage {
    name = "Apply STG"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-apply-STG"
      }
    }
  }
}

############## PRD ##############
resource "aws_codepipeline" "cicd_pipeline_PRD" {

  name     = "labthyl_networkbase_code_PRD"
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
    name = "Plan PRD"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-plan-PRD"
      }
    }
  }

  stage {
    name = "Apply PRD"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "tf-cicd-apply-PRD"
      }
    }
  }
}