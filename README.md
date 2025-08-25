## Installation

1. Clone repo: `git clone <url> && cd <dir>`
2. Init: `terraform init`

## Usage

1. Plan: `terraform plan`
2. Apply: `terraform apply`
3. Access: Use outputs like `cluster_endpoint` with `kubectl`. Get kubeconfig via YC CLI: `yc managed-kubernetes cluster get-credentials --id <cluster_id> --external`
4. Destroy: `terraform destroy`

## Modules

- **yc_vpc**: Creates VPC and zoned subnets with CIDR validation.
- **yc_k8s_master**: Deploys control plane; supports zonal/regional, maintenance policies.
- **yc_k8s_nodes**: Adds node groups with specs, scaling, disks.

Modules chain via outputs (e.g., VPC/subnet IDs).

## Outputs

- `vpc_net_id`, `map_zone_subids` (from yc_vpc).
- `cluster_id`, `cluster_endpoint` (from yc_k8s_master).

View: `terraform output`

## Example Config

In `terraform.tfvars`:
```
folder_id = "your-id"
```
Customize modules in `main.tf`, e.g., multi-zone subnets or regional cluster.