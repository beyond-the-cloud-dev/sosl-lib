---
sidebar_position: 4
---

# SUBQUERY

Specify child relationship name and pass list of fields.

```sql
SELECT Id, Name, (
    SELECT Id, Name FROM Contacts
) FROM Account
```
```apex
public inherited sharing class SOQL_Account extends SOSL implements SOSL.Selector {
    public static SOQL_Account query() {
        return new SOQL_Account();
    }

    private SOQL_Account() {
        super(Account.SObjectType);
        with(Account.Id, Account.Name);
    }
}

public with sharing class MyController {

    public static List<Account> getAccountsWithContacts() {
        return SOQL_Account.query()
            .with(SOSL.SubQuery.of('Contacts')
                .with(Contact.Id, Contact.Name)
            ).toList();
    }
}
```

SOSL supports relationship queries that traverse up to five levels of parent-child records.

[Query Five Levels of Parent-to-Child Relationships in SOSL Queries](https://help.salesforce.com/s/articleView?id=release-notes.rn_api_soql_5level.htm&release=244&type=5)

```sql
SELECT Name, (
    SELECT LastName , (
        SELECT AssetLevel FROM Assets
    ) FROM Contacts
) FROM Account
```
```apex
public inherited sharing class SOQL_Account extends SOSL implements SOSL.Selector {
    public static SOQL_Account query() {
        return new SOQL_Account();
    }

    private SOQL_Account() {
        super(Account.SObjectType);
        with(Account.Id, Account.Name);
    }
}

public with sharing class MyController {

    public static List<Account> getAccountsWithContactsAndTheirAssets() {
        return SOQL_Account.query()
            .with(SOSL.SubQuery.of('Contacts')
                .with(Contact.LastName)
                .with(SOSL.SubQuery.of('Assets')
                    .with(Asset.AssetLevel)
                )
            ).toList();
    }
}
```
