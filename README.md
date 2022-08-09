# Infinite-Backdoors
Bash Script with 4 ways to get persistence in Linux systems WITHOUT root permisions

**Usage:**

![image](https://user-images.githubusercontent.com/79543461/183771966-3a9e9a8b-e375-4878-835d-7e2937dd0d2e.png)

![image](https://user-images.githubusercontent.com/79543461/183772482-480cfcb4-2185-47a3-8537-376df6cee852.png)

![image](https://user-images.githubusercontent.com/79543461/183772594-a0dd769e-7e41-417d-8331-c14e984c8312.png)

**1. CronJobs**

The script will add these two lines of code to the Crontab configuration file.

Thanks to this you will be receiving a shell EVERY MINUTE

![image](https://user-images.githubusercontent.com/79543461/183772666-31e6311c-b70c-4f8d-86da-83758976f01f.png)

**2. SHELL CONFIG FILE**

The script will add these two lines of code to the BASH and ZSH terminal configuration file.

Thanks to this you will be receiving a shell every time the user opens a terminal

![image](https://user-images.githubusercontent.com/79543461/183773077-6a76f84b-9c6c-4af9-baf5-3673b892d346.png)

**3. SSH PRIVATE KEY**

This part of the code simply gives you the id_rsa file to be able to login via SSH

**4. WEB SERVER**

This part simply checks if there is any web server available and adds a PHP file with which you can execute system commands thanks to the CMD parameter that travels via GET

![image](https://user-images.githubusercontent.com/79543461/183773402-f77af617-249c-42e0-a11f-59d68f621dee.png)

Finally the script deletes itself and a file created during its execution permanently and untraceable with the command: shred

![image](https://user-images.githubusercontent.com/79543461/183773709-4b47d906-6b33-44f6-bb70-72697c9f2d69.png)
