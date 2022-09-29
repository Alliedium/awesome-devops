## Practice Generate self signed SSL Certificate
	
1. Prerequisites
		
Install python3 (Rocky)

```
sudo dnf install python3 -y
```

python is installed to manjaro. To run python script in manjaro use command

```
python ./my-script.py
```

2. Clone source files

```
git clone https://github.com/Alliedium/devops-course-2022.git
```

3. Go to ~\devops-course-2022\29_sep_2022_network_certificate_part_3\simple-https
	
4. Run scripts from 1 to 6.

5. In browser on a host on the same subnet as the https-server, enter the address

`https://<ip_address_https_server>:4443`
	
6. Check the certificate by clicking on the padlock in the address bar of the browser.