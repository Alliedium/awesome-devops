# CI/CD: Jenkins, Part 2

During this lecture, we will cover a diverse range of topics, providing you with a comprehensive understanding of various aspects related to Jenkins and its usage in software development workflows. The topics we will discuss include:

- Installing Jenkins with plugins using an Ansible playbook: We will walk you through the process of automating the installation of Jenkins, along with the installation of necessary plugins, using an Ansible playbook. This approach ensures a streamlined and consistent setup across multiple environments.

- Understanding LTS (Long Time Support) and weekly Jenkins releases: We will explore the different release cycles of Jenkins, including the LTS version that offers long-term stability and the weekly releases that provide the latest features and enhancements. 

-   Pipeline script and steps explanation: We will dive into the world of Jenkins pipelines, examining the script-based approach to defining and orchestrating your CI/CD processes. You will learn about the various pipeline steps and how they can be used to construct complex workflows.

- Setting parameters and environment variables in Jenkins: We will demonstrate how to define and utilize parameters and environment variables within Jenkins. 

- Maven, pom.xml, profile, static-code-analysis, lifecycles: We will explore Maven, a popular build tool, and its integration with Jenkins. You will gain an understanding of key Maven concepts such as the pom.xml configuration file, profiles, static code analysis, and build lifecycles. 

- Checkstyle configuration in pipeline, suppressions: We will focus on integrating Checkstyle, a static code analysis tool, into your Jenkins pipeline. 

## Prerequisites

Follow the instructions from [awesome-jenkins project](https://github.com/Alliedium/awesome-jenkins/blob/main/README.md#prerequisites) to prepare your environment
When starting the [Ansible playbook](https://github.com/Alliedium/awesome-jenkins/blob/main/README.md#instructions-to-install-jenkins-with-ansible-playbook), use tags to execute different stages of `Jenkins` installation. Use `step2` tags to install `Jenkins` with plugins, specified in the `$HOME/awesome-jenkins/playbooks/jenkins_plugins.yml` file.        
The [Alliedium/springboot-api-rest-example](https://github.com/Alliedium/springboot-api-rest-example) project is used to demonstrate the configuration and run the pipeline.

## Static code analysis and Code coverage analysis

1. Create multibranch pipeline on Jenkins via ansible playbook, use tag `step6`.
2. Open Jenkins link (by default, http://127.0.0.1:8085) in browser and run the build for multibranch pipeline job without suppression.
3. View reports for `Checkstyle`, `Findbugs`, `pmd/cpd`, and `JaCoCo`.
4. Rerun build with suppression. View trend for `Checkstyle` report.

## References

#### Maven

1. [Introduction to Build Profiles](https://maven.apache.org/guides/introduction/introduction-to-profiles.html)
2. [Guide to Maven Profiles](https://www.baeldung.com/maven-profiles)
3. [Maven Profiles: Detailed Explanation](https://medium.com/javarevisited/maven-profiles-detailed-explanation-1b4c8204466a)

#### Debugging Jenkins pipeline

4. [Script Console](https://www.jenkins.io/doc/book/managing/script-console/)
5. [Debugging Jenkins pipeline](https://notes.asaleh.net/posts/debugging-jenkins-pipeline/)
6. [Tips to Debug Jenkins v2.x Pipeline Script(s), Part 1](https://dzone.com/articles/10-tips-to-debug-jenkins-pipelines)
7. [jenkinsci/JenkinsPipelineUnit](https://github.com/jenkinsci/JenkinsPipelineUnit)

#### Static code analysis

8. [SpotBugs Maven Plugin](https://spotbugs.github.io/spotbugs-maven-plugin/)
9. [Maven PMD Plugin](https://pmd.github.io/latest/pmd_userdocs_tools_maven.html)
10. [Checkstyle](https://checkstyle.org/)
11. [Comparison of Static Code Analysis Tools for Java - Findbugs vs PMD vs Checkstyle](https://www.sw-engineering-candies.com/blog-1/comparison-of-findbugs-pmd-and-checkstyle)
12. [SpotBugs](https://spotbugs.readthedocs.io/en/stable/introduction.html)
13. [Using the SpotBugs Maven Plugin](https://spotbugs.readthedocs.io/en/stable/maven.html)
14. [Warnings Next Generation](https://plugins.jenkins.io/warnings-ng/)
15. [Top 15 Code Coverage Tools](https://www.softwaretestinghelp.com/code-coverage-tools/)
16. [JaCoCo > Documentation > Maven Plug-in](https://www.eclemma.org/jacoco/trunk/doc/maven.html)
17. [Intro to JaCoCo](https://www.baeldung.com/jacoco)
18. [HTML Publisher](https://plugins.jenkins.io/htmlpublisher/) 