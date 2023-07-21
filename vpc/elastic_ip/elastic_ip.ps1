param([string]$eni_id)

Write-Output "Allocate an EIP"
Write-Output "--------------------------------------------------------------------------------------"

$eip_allocation_result = aws ec2 allocate-address --profile saa_c03_studies --region eu-west-1 | ConvertFrom-Json

Write-Output $eip_allocation_result.AllocationId
Write-Output $eip_allocation_result.PublicIp

Write-Output ""
Write-Output "Associating to an ENI"
Write-Output "--------------------------------------------------------------------------------------"

$eip_association_result = aws ec2 associate-address --allocation-id $eip_allocation_result.AllocationId --network-interface $eni_id --profile saa_c03_studies --region eu-west-1 | ConvertFrom-Json

Write-Output $eip_association_result.AssociationId

Write-Output ""
Write-Output "Describe"
Write-Output "--------------------------------------------------------------------------------------"

$eniData = aws ec2 describe-network-interfaces --network-interface-id $eni_id --profile saa_c03_studies --region eu-west-1 | ConvertFrom-Json

Write-Output $eniData.NetworkInterfaces[0].Association.AllocationId
Write-Output $eniData.NetworkInterfaces[0].Association.AssociationId
Write-Output $eniData.NetworkInterfaces[0].PublicIp
Write-Output $eniData.NetworkInterfaces[0].AvailabilityZone
Write-Output $eniData.NetworkInterfaces[0].NetworkInterfaceId
Write-Output $eniData.NetworkInterfaces[0].SubnetId
Write-Output $eniData.NetworkInterfaces[0].VpcId
Write-Output $eniData.NetworkInterfaces[0].Status
