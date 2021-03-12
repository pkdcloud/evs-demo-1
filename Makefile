BACKEND_CONFIG ?= -backend-config="bucket=envirosuite-terraform-backend" -backend-config="key=evs-aws-terraform/$(TERRAFORM_ROOT_MODULE)" -backend-config="region=ap-southeast-2" -backend-config="profile=envirosuite-mgmt" -backend-config="dynamodb_table=envirosuite-terraform-lock"
MODS_DIRECTORY ?= ./scripts

init: .env
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd $(TERRAFORM_ROOT_MODULE); terraform init $(BACKEND_CONFIG)'
.PHONY: init

#This target is only used in the event you are creating backend for the first time
# init: .env
# 	docker-compose run --rm envvars ensure --tags terraform
# 	docker-compose run --rm terraform-utils sh -c 'cd ${TERRAFORM_ROOT_MODULE}; terraform init'
# .PHONY: init

plan: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd ${TERRAFORM_ROOT_MODULE}; terraform plan'
.PHONY: plan

planAuto: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd $(TERRAFORM_ROOT_MODULE); terraform plan -out ../$(TERRAFORM_ROOT_MODULE)-$(TERRAFORM_WORKSPACE).tfplan'
.PHONY: planAuto

apply: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd ${TERRAFORM_ROOT_MODULE}; terraform apply'
.PHONY: apply

applyAuto: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd ${TERRAFORM_ROOT_MODULE}; terraform apply -auto-approve ../$(TERRAFORM_ROOT_MODULE)-$(TERRAFORM_WORKSPACE).tfplan'
.PHONY: applyAuto

destroy: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd ${TERRAFORM_ROOT_MODULE}; terraform destroy'
.PHONY: destroy

runScripts: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd ${MODS_DIRECTORY}; terraform destroy'
.PHONY: runScripts

workspace: .env
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'cd $(TERRAFORM_ROOT_MODULE); terraform workspace select $(TERRAFORM_WORKSPACE) || terraform workspace new $(TERRAFORM_WORKSPACE)'
.PHONY: workspace

.env:
	touch .env
	docker-compose run --rm envvars validate
	docker-compose run --rm envvars envfile --overwrite
.PHONY: .env
