# 73 CI/CD: Jenkins node, Jenkins users, GitHub Actions, part 6

## 1. Jenkins node
Follow the instructions to create Jenkins [node](https://github.com/Alliedium/awesome-jenkins#create-jenkins-node-on-vm)
## 2. Manage Jenkins users
To implement fine-grained access control with Jenkins Matrix Authorization Strategy plugin follow the [instructions](https://github.com/Alliedium/awesome-jenkins#manage-users-in-jenkins) Jenkins plugin 

## GitHub Actions

Fork the repository to run examples with GitHub actions [workflows](https://github.com/Alliedium/awesome-github-actions/)
 
| Example                                                                                                                   | Code                                                                                                                  |
|---------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| [Example 7: Job matrix](https://github.com/Alliedium/awesome-github-actions#example-07-job-matrix)                              | [Job matrix](https://github.com/Alliedium/awesome-github-actions/blob/main/.github/workflows/07-job-matrix.yml)         |
| [Example 8: Outputs](https://github.com/Alliedium/awesome-github-actions#example-08-outputs)         | [Outputs](https://github.com/Alliedium/awesome-github-actions/blob/main/.github/workflows/08-outputs.yml)       |

## References
#### Jenkins nodes
1. [How to configure Jenkins master and slave nodes](https://digitalvarys.com/how-to-configure-jenkins-master-slave-setup/)
2. [Jenkins ssh-slaves plugin](https://plugins.jenkins.io/ssh-slaves/)
3. [Managing Jenkins nodes](https://www.jenkins.io/doc/book/managing/nodes/)
4. [Video: Jenkins node setup](https://www.youtube.com/watch?v=99DddJiH7lM)

#### Manage Jenkins users
5. [Matrix authorization strategy Jenkins plugin](https://plugins.jenkins.io/matrix-auth/)
6. [Role strategy Jenkins plugin](https://plugins.jenkins.io/role-strategy/) 
7. [Login to Jenkins using your own, self-hosted or public openid connect server](https://plugins.jenkins.io/oic-auth/)
8. [How to reset Jenkins admin password](https://tecadmin.net/reset-jenkins-admin-password/)

#### GitHub Action
9. [GitHub Actions common actions](https://github.com/actions)
10. [Good security practices for using GitHub Actions features](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
11. [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
12. [Outputs for jobs](https://docs.github.com/en/actions/using-jobs/defining-outputs-for-jobs)
13. [Output commands](https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/)