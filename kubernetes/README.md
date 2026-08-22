### Creating EKS cluster using eksctl:
###### eksctl create cluster   --name jenkins-cluster   --region us-east-1   --nodegroup-name workernodes   --node-type t3.small   --nodes 2   --nodes-min 1   --nodes-max 2
###### aws eks update-kubeconfig --region us-east-1 --name jenkins-cluster

### Prerequisites:
###### - kubectl
###### - eksctl
###### - aws 
