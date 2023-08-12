$ErrorActionPreference = "Stop"

$Separator = "---------------------------------------------------------------------------------------------------"
$aws_profile = "saa_c03_studies"
$aws_region = "eu-west-1"
$dynamo_database_name = "chapter05-books-database"

function header($Message) {
    $Header = "=========================================[ " + $Message + " ]========================================="
    Write-Output $Header
}

function booksPopulate() {
    header("Populating")

    Import-CSV -Path .\my_library.csv | ForEach {
        $BookData = $_
        $Message = "Processing item [" + $BookData.Id + "]"
        $BookInfo = $BookData.BookName + ", Written by " + $BookData.FirstName + " " + $BookData.LastName

        Write-Output $Separator
        Write-Output $Message
        Write-Output $BookInfo

        $source_item_file = "item_file_template.json"
        $destination_file = "item_file.json"

        (Get-Content $source_item_file) | Foreach-Object {
            $_ -replace 'IDENTIFIER', $BookData.Id `
               -replace 'BOOK_NAME', $BookData.BookName `
               -replace 'LAST_NAME', $BookData.LastName `
               -replace 'FIRST_NAME', $BookData.FirstName `
        } | Set-Content $destination_file

        aws dynamodb put-item `
            --table-name $dynamo_database_name `
            --item file://$destination_file `
            --profile $aws_profile `
            --region $aws_region

        Remove-Item -Path $destination_file
    }
}

function booksFindById($Id) {
    header("Finding By Id")

    $source_item_file = "query_by_id_template.json"
    $destination_file = "query_by_id.json"

    (Get-Content $source_item_file) | Foreach-Object {
        $_ -replace 'IDENTIFIER', $Id `
        } | Set-Content $destination_file

    aws dynamodb query `
        --table-name $dynamo_database_name `
        --key-condition-expression "Id = :id" `
        --expression-attribute-values file://$destination_file `
        --profile $aws_profile `
        --region $aws_region

    Remove-Item -Path $destination_file
}

function booksScanByBookName($BookName) {
    header("Find by Book Name")

    $source_item_file = "scan_by_book_name_template.json"
    $destination_file = "scan_by_book_name.json"

    (Get-Content $source_item_file) | Foreach-Object {
        $_ -replace 'BOOK_NAME', $BookName `
        } | Set-Content $destination_file

    aws dynamodb scan `
        --table-name $dynamo_database_name `
        --filter-expression "Book = :bookName" `
        --projection-expression "#ID, #BN, #FN, #LN" `
        --expression-attribute-names file://projection.json `
        --expression-attribute-values file://$destination_file `
        --profile $aws_profile `
        --region $aws_region

    Remove-Item -Path $destination_file
}

# Pending
function booksScanByFirstName($FirstName) {
    $Query="{ \"":firstName\"": {\""S\"": \""" + $FirstName + "\""}}"

    aws dynamodb query --table $dynamo_database_name --key-condition-expression "FirstName=:firstName" --expression-attribute-values $Query --profile $aws_profile --region $aws_region
}

# Pending
function booksScanByLastName($LastName) {
    $Query="{ \"":lastName\"": {\""S\"": \""" + $LastName + "\""}}"

    aws dynamodb query --table $dynamo_database_name --key-condition-expression "LastName=:lastName" --expression-attribute-values $Query --profile $aws_profile --region $aws_region
}

# Pending
function booksScanByName($FirstName, $LastName) {
    $Query="{ \"":lastName\"": {\""S\"": \""" + $LastName + "\""}, \"":firstName\"": {\""S\"": \""" + $FirstName + "\""}}"

    aws dynamodb query --table $dynamo_database_name --key-condition-expression "FirstName=:firstName AND LastName=:LastName" --expression-attribute-values $Query --profile $aws_profile --region $aws_region
}

Export-ModuleMember -Function booksPopulate
Export-ModuleMember -Function booksFindById
Export-ModuleMember -Function booksScanByBookName
#Export-ModuleMember -Function findByFirstName
#Export-ModuleMember -Function findByLastName
#Export-ModuleMember -Function findByName
