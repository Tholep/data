# Specify the username and domain
$username = "abc"
$domain = "test.local"

# Construct the LDAP path
$ldapPath = "LDAP://$domain"

# Create a DirectoryEntry object for the specified LDAP path
$directoryEntry = New-Object System.DirectoryServices.DirectoryEntry($ldapPath)

# Create a DirectorySearcher object
$searcher = New-Object System.DirectoryServices.DirectorySearcher($directoryEntry)

# Set the filter to search for the specified username
$searcher.Filter = "(&(objectCategory=User)(sAMAccountName=$username))"

# Perform the search
$searchResult = $searcher.FindOne()

# Display all attributes if the user is found
if ($searchResult -ne $null) {
    $userAttributes = $searchResult.Properties.PropertyNames | ForEach-Object {
        $_ + ": " + $searchResult.Properties[$_]
    }
    
    $userAttributes
} else {
    Write-Host "User not found: $username"
}
