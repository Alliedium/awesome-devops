## Practice --- Issuing a public certificate using the ACME protocol and make SSL termination with public certificate
	
1. Clone source files

```
git clone https://github.com/Alliedium/devops-course-2022.git
```

2. Go to `~/devops-course-2022/29_sep_2022_network_certificate_part_3/simple-https`
	
3. Run http server on Rocky linux.

```
python3 simple-server-http.py
```

Run http server on Manjaro linux.

```
python simple-server-http.py
```

4. In a browser navigate to `https://aws.amazon.com/ru/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all`
and create new AWS account
 
5. Log in Amazon using `root user`

6. Go to IAM page, edit `Account Alias` and create `admin user`

7. Log out and log in using `admin user`.

8. Go to `IAM` page, create `acme_user_bot` for programmatic access. Save localy file with `acme_user_bot's` credentials.

9. Go to `Route 53` page, create your domain.

10. In `Hosted zones` of your domain create record of type A (creating your subdomain).
 
11. Check domain in your terminal with `nslookup` tool.

* Install  bind-utils in Rocky for `nslookup`

```
sudo dnf install bind-utils -y
```
			
* Install bind in Manjaro for `nslookup`

```
sudo pacman -S bind
```
	
* Check your domain
	
```
nslookup <your_created_domain>
```

12. In your OpnSense install `ACME` plugin.

13. In OpnSense, `ACME` plugin, set up 
 - `Settings`
 - `Accounts`
 - `Challenge Types`
 - `Certificates`.
 
14. In OpnSense, nginx plugin, set up 
 - `Upstream Server`
 - `Upstream` (Group of Upstream Servers)
 - `Location`
 - `HTTP Server`.
 

15. Open access in OpnSense for WAN on port `9443 (HTTPS Listener port)`

16. Make port forwarding for 9443 port on your home router to <wan_opnsense_ip_address>.

17. Check https server (TLS termination), on your home machine in a browser enter the address

`https://<your_created_domain>:9443`

18. Check public certificate.
