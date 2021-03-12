# evs-demo-1

EVS Demo Repository. Dummy Horizon Stack

## Deploy

```
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-collection make apply
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-processing make apply
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-presentation make apply
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-storage make apply
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-reporting make apply
```

# Destroy

```
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-collection make destroy
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-processing make destroy
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-presentation make destroy
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-storage make destroy
TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-reporting make destroy
```