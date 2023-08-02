# CI/CD: Jenkins, Part 3

In our examples, we use the [Alliedium/awesome-jenkins](https://github.com/Alliedium/awesome-jenkins) playbook, which shows the commands used.

Throughout this session, we will delve into the following subjects:

- Ansible tags, jenkins_script, jenkins_job, and jenkins_job_info Ansible modules. We will explore Ansible modules such as jenkins_script, jenkins_job, and jenkins_job_info, which facilitate seamless interaction with Jenkins from within Ansible, enabling you to automate various tasks.

- Ansible playbook testing with `Molecule`: `Molecule` is a powerful testing framework for Ansible playbooks. We will showcase how to utilize Molecule. This approach enables you to validate the functionality of your Ansible playbooks before deploying them to production.

- Ansible playbook testing with GitHub Actions: GitHub Actions provides a seamless integration with Ansible, allowing you to automate various workflows, including playbook testing. We will demonstrate how to leverage GitHub Actions to automatically trigger and execute tests on your Ansible playbooks, providing continuous integration and ensuring the quality of your automation code.

## Prerequisites

Follow the instructions from [awesome-jenkins project](https://github.com/Alliedium/awesome-jenkins/blob/main/README.md#prerequisites) to prepare your environment
When starting the [Ansible playbook](https://github.com/Alliedium/awesome-jenkins/blob/main/README.md#instructions-to-install-jenkins-with-ansible-playbook), use tags to execute different stages of `Jenkins` installation. Use `step2` tags to install `Jenkins` with plugins, specified in the `$HOME/awesome-jenkins/playbooks/jenkins_plugins.yml` file.        
The [Alliedium/springboot-api-rest-example](https://github.com/Alliedium/springboot-api-rest-example) project is used to demonstrate the configuration and run the pipeline.

## Molecule test of Jenkins installation 

1. Run molecule test locally to check Jenkins is correctly installed with plugins and pipeline build is successfully running. Follow the [instructions](https://github.com/Alliedium/awesome-jenkins/#5-ansible-playbook-local-testing-with-molecule).       
2. Run molecule test via [GitHub Actions](https://github.com/Alliedium/awesome-jenkins/#6-ansible-playbook-remote-testing-with-github-actions)

## References

1. [Using GitHub App authentication](https://docs.cloudbees.com/docs/cloudbees-ci/latest/cloud-admin-guide/github-app-auth)
2. [jenkinsci/github-checks-plugin](https://github.com/jenkinsci/github-checks-plugin)
3. [jenkinsci/github-branch-source-plugin](https://github.com/jenkinsci/github-branch-source-plugin/blob/master/docs/github-app.adoc)
4. [Understanding GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions)
5. [About Ansible Molecule](https://molecule.readthedocs.io/)
6. [Molecule, Continuous integration](https://molecule.readthedocs.io/ci/)