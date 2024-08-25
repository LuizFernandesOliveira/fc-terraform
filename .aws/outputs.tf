locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.fullcycle-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.fullcycle-cluster.certificate_authority[0].data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: "${aws_eks_cluster.fullcycle-cluster.name}"
  name: "${aws_eks_cluster.fullcycle-cluster.name}"
current-context: "${aws_eks_cluster.fullcycle-cluster.name}"
kind: Config
preferences: {}
users:
- name: "${aws_eks_cluster.fullcycle-cluster.name}"
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.fullcycle-cluster.name}"
KUBECONFIG
}

resource "local_file" "kubeconfig" {
  filename = "kubeconfig"
  content  = local.kubeconfig
}