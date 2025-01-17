output "cluster_name" {
  description = "The name of the deployed AKS Automatic Cluster"
  value       = azapi_resource.aks.name
}

output "cluster_id" {
  description = "The Id of the deployed AKS Automatic Cluster"
  value       = azapi_resource.aks.id
}