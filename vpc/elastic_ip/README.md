# Elastic IP

Creates an elastic IP and associates to a given Network Interface.

## How to use

First run the terraform script for the module `simple_vpc` and save the ENI_ID.

Later run ths `elastic_ip.ps1` script wtih the following syntax:

```powershell
elastic_ip.ps1 -eni_id <ENI_ID>
```

Wait for a moment to the script complete and check your AWS Console.