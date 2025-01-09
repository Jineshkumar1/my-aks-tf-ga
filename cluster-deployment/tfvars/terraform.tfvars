resource_group_name = "rg-velidaaks"
location = "useast"
tags = {
  environment = "prod"
  owner = "willvelida"
  application = "velidaaks"
  location = "useast"
  sub = "MVP-sub"
  type = "POC"
}
user_assigned_identity_name = "prod-uai-velidaaks"
acr_name = "prodacrvelidaaks"
vm_size = "Standard_D2s_v3"
aks_username = "willvelida"
aks_name = "prod-velidaaks"
azure_monitor_workspace_name = "prod-amw-velidaaks"
grafana_name = "prod-grafana-velidaaks"
enable_azure_policy = true

tenant_id = "fb13b857-a984-4fe8-b9c8-d8e8a3c0480a"
client_id = "f285429-6b6e-4738-9f29-625d4fac28d3"