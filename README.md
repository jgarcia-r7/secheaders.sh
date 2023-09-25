# secheaders.sh
Secheaders.sh - Check for Missing Security-Related HTTP Headers
### Description
Secheaders.sh is a simple bash script that uses Curl to retrieve the response headers from a target URL. The script then checks for these five headers:
- Strict-Transport-Security
- X-Content-Type-Options
- X-Frame-Options
- Content-Security-Policy
- X-Permitted-Cross-Domain-Policies

#### Usage
```bash
./secheaders.sh -u <target-url>
```
#### Preview
![image](https://github.com/jgarcia-r7/secheaders.sh/assets/81575551/1d33cd5f-e833-414e-937c-3c574447600e)
