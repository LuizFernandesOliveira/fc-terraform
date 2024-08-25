resource "aws_iam_role" "fullcycle-cluster-node-role" {
  name               = "${var.prefix}-${var.cluster_name}-node-role"
  assume_role_policy = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  POLICY
}

resource "aws_iam_role_policy_attachment" "fullcycle-cluster-node-AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.fullcycle-cluster-node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "fullcycle-cluster-node-AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.fullcycle-cluster-node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "fullcycle-cluster-node-AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.fullcycle-cluster-node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_node_group" "fullcycle-cluster-node-1" {
  cluster_name    = aws_eks_cluster.fullcycle-cluster.name
  node_group_name = "${var.prefix}-${var.cluster_name}-node-1"
  node_role_arn   = aws_iam_role.fullcycle-cluster-node-role.arn
  subnet_ids      = aws_subnet.fullcycle-subnets[*].id
  instance_types  = ["t3.micro"]
  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.fullcycle-cluster-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.fullcycle-cluster-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.fullcycle-cluster-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}