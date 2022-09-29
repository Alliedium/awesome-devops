## Practice Generate self signed SSL Certificate
	
Prerequisites
		
Install python3 (Rocky)

```
sudo dnf install python3 -y
```

Install python3 (Manjaro)

```
sudo pacman -Sy python3
```

Clone source files

```
git clone https://github.com/Alliedium/devops-course-2022.git
```

Go to ~\devops-course-2022\29_sep_2022_network_certificate_part_3\simple-https
	
Run scripts from 1 to 6.
In browser on a host on the same subnet as the https-server, enter the address

`https://<ip_address_https_server>:4443`
	
Check the certificate by clicking on the padlock in the address bar of the browser.