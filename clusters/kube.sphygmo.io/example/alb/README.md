# Using ALB as Ingress

Everything here is taken from https://kubernetes-sigs.github.io/aws-alb-ingress-controller/

Few things to note:
 * Services should be be nodeport type
 * Make sure you have the right annotations across the k8s AWS resources
