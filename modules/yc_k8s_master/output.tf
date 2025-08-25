output "cluster_id" {
    description = "Id of created k8s cluster"
    value = yandex_kubernetes_cluster.test_cluster.id
}

output "cluster_endpoint" {
    description = "Cluster endpoint"
    value = yandex_kubernetes_cluster.test_cluster.master[0].external_v4_endpoint
}