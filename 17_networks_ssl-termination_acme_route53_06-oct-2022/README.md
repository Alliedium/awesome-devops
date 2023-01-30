# Issuing a public certificate using the `ACME` protocol and make SSL termination with public certificate

## Prerequisites ##

### 1. Create and install `OPNsense` as shown in [previous lesson](../16_networks_ssl-termination_self-signed_cert_04-oct-2022/README.md).

### 2. Clone source files

  ```
  git clone https://github.com/Alliedium/devops-course-2022.git
  ```

## Run http server ##

  - Go to `~/devops-course-2022/15_networks_dsa_ca_ssl-certificates_opnsense_29-sep-2022/simple-https`
  - Run http server on `Rocky` Linux.
  
  ```
  python3 simple-server-http.py
  ```

  - Run http server on `Manjaro` Linux.
  
  ```
  python simple-server-http.py
  ```

## Create new account, users and domain in AWS (Amazon Web Services)
  
  1. In a browser navigate to `https://aws.amazon.com/ru/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all` and create new AWS account

  ![create_aws_account](./images/create_aws_account.png)

  2. Log in Amazon using `root user`
   
   ![aws_login_root](./images/aws_login_root.png)

  3. Go to IAM page, edit `Account Alias` 

  ![account_alias](./images/account_alias.png)

  and create `admin user`

  ![account_alias](./images/create_aws_user.png)

  4. Log out and log in using `admin user`.

  ![aws_login_user](./images/aws_login_user.png)

  5. Go to `IAM` page, create `acme_user_bot` for programmatic access. Save local file with `acme_user_bot's` credentials.

   Copy policy form [How to use Amazon Route53 API](https://github.com/acmesh-official/acme.sh/wiki/How-to-use-Amazon-Route53-API) while creating bot.

  ![create_bot](./images/create_bot.png)

  In policy past `hosted zone ID`

  ![hosted_zone_id](./images/hosted_zone_id.png)

  Create access key for created user

  ![generate_access_key](./images/generate_access_key.png)

  6. Go to `Route 53` page, create your domain.

  ![register_domains](./images/register_domains.png)

  7.  In `Hosted zones` of your domain create record of type A (creating your subdomain).

  ![hosted_zone](./images/hosted_zone.png)

  8.  Check domain in your terminal with `nslookup` tool.

  * Install  bind-utils in `Rocky` for `nslookup`
  
  ```
  sudo dnf install bind-utils -y
  ```

  * Install bind in `Manjaro` for `nslookup`

  ```
  sudo pacman -S bind
  ```

  * Check your domain

  ```
  nslookup <your_created_domain>
  ```

  ![check_domain](./images/check_domain.png)

## Installing and configuring the `ACME` plugin in `OPNsense` for obtaining and renewing a `SSL` certificate

  1.  In your `OPNsense` install `ACME` plugin.

  ![acme_install](./images/acme_install.png)

  2. In `OPNsense -> Services -> ACME client`, set up 
   
     - `Settings`

     ![acme_settings](./images/acme_settings.png)

     - `Accounts`
  
  
     ![acme_accounts](./images/acme_accounts.png)

     - `Challenge Types`

     ![challenge_type](./images/challenge_type.png)

     - Setting up obtaining and renewing a certificate through the `acme` plugin.

     ![certificate](./images/certificate.png)

  3.  Manually start certificate renewal 
    
  ![certificate](./images/manual_update_certificate.png)

  - After successfully obtaining or renewing the certificate, there should be such a log

  ![issued_log_certificate](./images/issued_log_certificate.png)

## Configuring the `nginx` plugin in `OPNsense`

  1. In `OPNsense -> Services -> Nginx` set up following items as in step `12. Configure nginx Load Balancer` of [`Configure OPNsense, nginx and create self-sign certificate (Lesson 16)`](../16_networks_ssl-termination_self-signed_cert_04-oct-2022/README.md) section.
      
     - `Upstream Server`
     - `Upstream` (Group of Upstream Servers)
     - `Location`
     - `HTTP Server`

     ![http_server_acme](./images/http_server_acme.png)

  2. Restart `nginx`

  ![restart_nginx](./images/restart_nginx.png)

## Check SSL certificate 

  1.  Open access in `OPNsense` from WAN subnet on port `9443 (HTTPS Listener port)`

  ![rule_9443](./images/rule_9443.png)

  2.  Make forwarding for 9443 port on your home router to <wan_opnsense_ip_address>.
  
  ![forwarding_9443_home_router](./images/forwarding_9443_home_router.png)

  3.  Check https server (TLS termination), on your home machine in a `Firefox` browser enter the address `https://<your_created_domain>:9443`

  4. Check public certificate.
    
  ![check_acme_certificate](./images/check_acme_certificate.png)

# References

1. [Free Tier](https://aws.amazon.com/ru/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)
2. [Top 10 Cloud Service Providers Globally in 2022](https://dgtlinfra.com/top-10-cloud-service-providers-2022/)
3. [How to use Amazon Route53 API](https://github.com/acmesh-official/acme.sh/wiki/How-to-use-Amazon-Route53-API)
4. [cert-manager](https://cert-manager.io/docs/)
5. [Rate Limits](https://letsencrypt.org/docs/rate-limits/)
6. [Securing HTTP Traffic to Upstream Servers](https://docs.nginx.com/nginx/admin-guide/security-controls/securing-http-traffic-upstream/)
7. [nginx: Basic Load Balancing](https://docs.opnsense.org/manual/how-tos/nginx.html)
