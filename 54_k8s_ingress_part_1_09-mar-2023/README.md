# Kubernetes, Ingress controller, PART 1 #

The lesson provides a introduction to Ingress controllers in Kubernetes. The instructor focuses on the NGINX Ingress Controller and demonstrates how to install and uninstall it using Helm, a popular package manager for Kubernetes.
The lesson starts by explaining the concept of Ingress controllers and their importance in enabling external access to services within a Kubernetes cluster. It then dives into the practical aspect of deploying the NGINX Ingress Controller with Helm, guiding students through the step-by-step installation process. Moreover, students learn how to customize the load balancer's IP address, allowing them to control external access to their applications more effectively.

The instructor covers essential Helm commands, such as `helm install` and `helm upgrade`, and emphasizes the significance of the `--cleanup-on-fail` flag to ensure a smooth rollback when dealing with installation failures.

The latter part of the lesson is dedicated to creating Ingress resources for backend services. 

Students gain hands-on experience in defining Ingress rules, routing traffic based on hostnames or paths, and ultimately accessing the backend services from external sources.

For demonstration, examples from the [awesome-kubernetes](https://github.com/Alliedium/awesome-kubernetes) were used.

# Prerequisites: #

- ### Clone [awesome-kubernetes](https://github.com/Alliedium/awesome-kubernetes) repo
  
  ```
  git clone https://github.com/Alliedium/awesome-kubernetes.git $HOME/awesome-kubernetes
  cd $HOME/awesome-kubernetes
  ```
- ### Please follow the steps of [Exposing service via HTTP mode within intranet](https://github.com/Alliedium/awesome-kubernetes/tree/main/11-nginx-ingress#1-exposing-service-via-http-mode-within-intranet) section, Example 11

# References
1. [ingress-nginx](https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx)
2. [Kubernetes Ingress with NGINX Ingress Controller Example](https://spacelift.io/blog/kubernetes-ingress)
3. [Automating Multi-Cluster DNS with NGINX Ingress Controller](https://www.nginx.com/blog/automating-multi-cluster-dns-with-nginx-ingress-controller/)
4. [Creating SSO Integrations for Multiple Apps](https://www.nginx.com/blog/implementing-openid-connect-authentication-kubernetes-okta-and-nginx-ingress-controller/)
5. [Advanced ingress configuration](https://docs.giantswarm.io/advanced/ingress/configuration/)
6. [k3s-ansible](https://github.com/techno-tim/k3s-ansible)
7. [Lesson 40 setting up production like kubernetes cluster, part_5](https://github.com/Alliedium/awesome-devops/tree/main/)