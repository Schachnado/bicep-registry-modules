//var
@description('The name of the virtual network.')
var vnetName = 'bestvnetname22'

@description('The name of the managed identity.')
var managedIdentityName = 'bestminame22'

@description('The name of the key vault.')
var keyVaultName = 'bestkvname22'

//param
@description('Required. The name of the storage account.')
param storageAccountName string

@allowed([
  'default'
  'recover'
])
@description('Optional. The mode to create the storage account. Default is default.')
param createMode string = 'default'

@allowed([
  true
  false
])
@description('Optional. Enable Hierarchical Namespace for the storage account. Default is true.')
param enableHierarchicalNamespace bool = true

//modules
module keyvault 'br/public:avm/res/key-vault/vault:0.11.0' = {
  name: 'keyvault'
  params: {
    name: keyVaultName
    createMode: createMode
  }
}

module storage 'br/public:avm/res/storage/storage-account:0.14.0' = {
  name: 'storage'
  params: {
    name: storageAccountName
    enableHierarchicalNamespace: enableHierarchicalNamespace
  }
}

module vnet 'br/public:avm/res/network/virtual-network:0.5.0' = {
  name: 'vnet'
  params: {
    name: vnetName
    addressPrefixes: [
      '10.1.0.0/16'
    ]
  }
}

module managedIdentity 'br/public:avm/res/managed-identity/user-assigned-identity:0.4.0' = {
  name: 'managedIdentity'
  params: {
    name: managedIdentityName
  }
}
