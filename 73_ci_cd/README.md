# CI/CD: Jenkins integration with GitHub.  6

## 1. Integration with GitHub
## 2. Jenkins agent
   Follow steps from awesome-jenkins## Create Jenkins node on VM
## 3. Manage Jenkins users
   Follow steps from awesome-jenkins## Create Jenkins node on VM
  Create new user: Go to Manage Jenkins -> Users
 Manage Jenkins -> Security
Authorization: Project-based Matrix Authorization security
Add user
set permissions
save
Go to Dashboard
Open configuration of existing pipeline
Check `Enable project-based security`
Inheritance Strategy: 

Dashboard -> Nodes > agent > configure
Check `Enable node-based security`

## GitHub Actions
1. Matrix job
Description from 
2. Output job
Description from
3. 
## References
#### Jenkins nodes
1. [How to configure Jenkins master and slave nodes](https://digitalvarys.com/how-to-configure-jenkins-master-slave-setup/)
2. [Jenkins ssh-slaves plugin](https://plugins.jenkins.io/ssh-slaves/)
3. [Managing Jenkins nodes](https://www.jenkins.io/doc/book/managing/nodes/)
4. [Video: Jenkins node setup](https://www.youtube.com/watch?v=99DddJiH7lM)

#### Manage Jenkins users
1. [Matrix authorization strategy Jenkins plugin](https://plugins.jenkins.io/matrix-auth/)
2. [Role strategy Jenkins plugin](https://plugins.jenkins.io/role-strategy/) 
3. [Login to Jenkins using your own, self-hosted or public openid connect server](https://plugins.jenkins.io/oic-auth/)
4. [How to reset Jenkins admin password](https://tecadmin.net/reset-jenkins-admin-password/)