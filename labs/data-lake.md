# [Docs](../README.md) > [Labs](./index.md) > **IAC Intro - Deploying a Data Lake on AWS**

`A Slalom DataOps Lab`

## Lab Objectives

- Create a new repository from an existing template repo.
- Clone and open the new repository on your local workstation.
- Customize the infrastructure and add credentials as needed.
- Use `terraform apply` to deploy the foundations of the core data lake environment, including three S3 buckets, the VPC, and the public and private subnets.

## Setup

- One-time setup:
  - Installed software via:
    1. Core DevOps Tools: [http://docs.dataops.tk/setup](http://docs.dataops.tk/setup)
    2. AWS CLI:
        - `choco install awscli` (Windows)
        - `brew install awscli` (Mac)
- Environment setup (each time):
  - Open browser tabs:
    1. The lab checklist (this page)
    2. [linux academy](https://app.linuxacademy.com/dashboard)
    3. [slalom-ggp/dataops-project-template](https://github.com/slalom-ggp/dataops-project-template)

## Lab Steps

### Step 1: Create a Repo and a New AWS Account

- [ ] Create new repo from the [Slalom DataOps Template](https://github.com/slalom-ggp/dataops-project-template), clone repo locally and open in VS Code.
- [ ] Get AWS credentials from Linux Academy.
- [ ] Use the linux-academy link to log in to AWS in the web browser.

### Step 2: Configure Credentials

- [ ] In the `.secrets` folder, rename `aws-credentials.template` to `aws-credentials`.
- [ ] Copy-paste your AWS credentials (from Linux Academy Playground) into the correct location within the template.
- [ ] In the `.secrets` folder, rename `aws-secrets-manager-secrets.yml.template` to `aws-secrets-manager-secrets.yml` (no addl. secrets needed in this exercise)

### Step 3: Configure Project

- [ ] Rename `infra-config-template.yml` to `infra-config.yml`
- [ ] Within infra-config.yml, update your email address and your project shortname.

### Step 4: Configure and Deploy Terraform

- [ ] Open the `infra` folder, review the contents of the two files:
  - `00_environment.tf`
  - `01_data-lake.tf`
- [ ] Delete the two extra files in `infra`:
  - `02_singer-taps.tf`.
  - `03_data-build-tool.tf`
- [ ] Right-click the `infra` folder and select "Open in Terminal" (or from an existing terminal window, run `cd infra`).
- [ ] In the terminal windows that opens, run `terraform init` and `terraform apply`, then type 'yes' to deploy.
- [ ] Wait for `terraform apply` to complete (approx. 2 minutes).
- [ ] In the web browser, browse your AWS console to S3 buckets and confirm the new data lake buckets are created.

### Extra Credit Options

_These bonus exercises are optional._

#### EC Option #1: Upload a sample file to the data lake

- [ ] After completing the steps above, go to the output from `terraform apply` (or alternatively you can run `terraform output`) and then copy the provided `AWS User Switch` command.
- [ ] Paste the `AWS User Switch` command into your terminal so that aws-cli can correctly locate your AWS credentials.
- [ ] Upload infra-config.yml to the data bucket: `aws s3 cp ../infra-config.yml s3://...`
- [ ] List the bucket contents with `aws s3 ls s3://...`
- [ ] In the web browser, browse to the bucket and confirm the file has landed.

#### EC Option #2: Spin up Airflow on EC2

- [ ] Copy the contents of the [airflow sample file](https://github.com/slalom-ggp/dataops-infra/blob/master/samples/airflow-on-aws/02_airflow.tf) into a new `.tf` file in the infra folder.
- [ ] Review the airflow module configuration and update the `source` value in the airflow file so that it matches the source prefix for the github repo (replacing the `../..` relative references).
  - _Tip: You can use the file `01_data-lake.tf` as a sample for what `source` should look like when referencing an external module._
- [ ] Rerun terraform apply and note the error message.
- [ ] Rerun terraform init and then run terraform apply again.
- [ ] In the web browser, browse to your new airflow instance.

## Troubleshooting

1. "Error 400 ... Policy Document Must Contain Resources"
    - This was an interim issue caused by an unneeded (empty) policy being created.
    - In general, you can ignore this error and proceed with the next steps to validate the environment.
    - To resolve the issue, first run `terraform init --upgrade`, then rerun `terraform apply`.
    - If you are using Linux Academy Playground, please also consult the AWS Sandbox troubleshooting tip #3 (below) on how to restart a fresh environment if yours has timed out.
2. "Error 403 ... InvalidClientTokenId"
    - This most often means there's a problem with your AWS credentials file.
    - If the `aws-credentials` file is still open, make sure you use `ctrl+s` to save the file if it is not yet saved.
    - If the above does not resolve the issue, you may need to return to Linux Academy Playground and make sure your AWS Sandbox is still running.
    - As a last check, it is a good idea to double-check that the AWS key pair pasted matches the Linux Academy AWS credentials.
3. Errors after restarting the AWS Sandbox in Linux Academy Playground
    - If you run out of time on your playground account (4 hour limit), you will have to create a new environment.
    - In this case, you will also have to delete the `terraform.tfstate` file - since otherwise terraform will unsuccessfully try to manage objects which no longer exist and which are not accessible from the new AWS account.
    - Warning: in normal environments (aka when not using Linux Academy Playground), you you should not delete the `tfstate` file and instead you can simply run `terraform destroy`.
4. PowerShell (PS) Terminal issues (Windows only)
    - The `AWS User Switch` command is in the syntax of Command Prompt and does not work properly in PowerShell.
    - If you are running in PowerShell, either: (option A) run `cmd` to switch to command prompt before running the commands, or (option B) within PowerShell, replace `SET AWS_SHARED_CREDENTIALS_FILE=...` with `$env:AWS_SHARED_CREDENTIALS_FILE="..."`.
5. Unwanted email notifications due to scheduled CI/CD jobs failing.
    - Earlier versions of this lab had daily jobs scheduled by default, which would fail and send unwanted failure notifications.
    - To disable these notifications, perform any one of the three options below:
      1. Navigate to the folder `.github/workflows` and delete the file `daily_refresh.yml` and then commit and push the change to GitHub.
      2. Navigate to the GitHub repo on GitHub.com, open the "Settings", then under "Actions" select the option to disable all actions in the repo.
      3. Navigate to your personal [GitHub Notification Settings page](https://github.com/settings/notifications) and uncheck "Email" in the "GitHub Actions" section.

## See Also

- [Original Lab Text](https://github.com/slalom-ggp/dataops-infra/issues/85)
