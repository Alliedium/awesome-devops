# Create a VM with static IP configuration and ssh public key access
param(
	[String]$vmNamePrefix = 'k3s-node-',
	[String]$vmId = '1'
)
$imgFile = .\Get-UbuntuImage.ps1 -Verbose
$userName = 'k3s-user'
$userPassword = '$6$ZB76EpO5DN2in$fbg/CPvsWz/ixLBtda3UkVvwlf0uVTRGTqDzVdv3yqYsR2MA7YW.fIEDByILnAwzF.LYQhBghhKWMbN43YYLt/'
$userPublicKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa_cloudinit_k3s.pub"
$ipAddressPrefix = '10.10.0.1'
$SubnetMask = 24
$ipAddress = "$ipAddressPrefix$vmId/$SubnetMask"
if (!$vmNamePrefix) {
	$vmNamePrefix = 'k3s-node-'
}
if ($vmNamePrefix.Contains('config')) {
	$vmName = "$vmNamePrefix"
}
else {
	$vmName = "$vmNamePrefix$vmId"
}
$vmNamePrefix = $vmNamePrefix.Trim()
$DnsAddresses = "10.10.0.1"
$Gateway = "10.10.0.1"
$VlanId = "10"
$ProcessorCount = 8
$MemoryStartupBytes = 2GB
$VHDXSizeBytes = 8GB

echo "Start creating VM, userName [$userName], ipAddress [$ipAddress], vmName [$vmName], vmId [$vmId]"

.\New-VMFromUbuntuImage.ps1 -SourcePath $imgFile -VMName "$vmName" -UserName $userName -UserPassword $userPassword -UserPublicKey $userPublicKey -VHDXSizeBytes $VHDXSizeBytes -MemoryStartupBytes $MemoryStartupBytes -ProcessorCount $ProcessorCount -SwitchName 'vmbr0' -IPAddress "$ipAddress" -Gateway $Gateway -DnsAddresses $DnsAddresses -VlanId $VlanId -Verbose
