---
sidebar_position: 6
---

# WHERE

Use [SOSL.FilterGroup](../api/sosl-filters-group.md) and Use [SOSL.Filter](../api/sosl-filter.md) to build your `WHERE` clause.

Define basic filters in your Selector class.

```sql
SELECT Id, Name
FROM Account
WHERE Id = :accountId OR Name LIKE :'%' + accountName + '%'
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

    public SOQL_Account byRecordType(String rt) {
        whereAre(Filter.recordType().equal(rt));
        return this;
    }

    public SOQL_Account byIndustry(String industry) {
        with(Account.Industry)
            .whereAre(Filter.with(Account.Industry).equal(industry));
        return this;
    }

    public SOQL_Account byParentId(Id parentId) {
        with(Account.ParentId)
            .whereAre(Filter.with(Account.ParentId).equal(parentId));
        return this;
    }
}

public with sharing class MyController {

    @AuraEnabled
    public static List<Account> getAccountsByRecordType(String recordType) {
        return SOQL_Account.query()
            .byRecordType(recordType)
            .byIndustry('IT')
            .with(Account.Industry, Account.AccountSource)
            .toList();
    }

    @AuraEnabled
    public static List<Account> getByIdOrName(Id accountId, String accountName) {
        return SOQL_Account.query()
            .whereAre(SOSL.FilterGroup
                .add(SOSL.Filter.id().equal(accountId))
                .add(SOSL.Filter.name().contains(accountName))
                .anyConditionMatching() // OR
            )
            .toList();
    }
}
```

## Custom Order

```sql
SELECT Id
FROM Account
WHERE (Name = 'My Account' AND NumberOfEmployees >= 10)
OR (Name = 'My Account' AND Industry = 'IT')
```
```apex
SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.name().equal('My Account'))
        .add(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10))
        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
        .conditionLogic('(1 AND 2) OR (1 AND 3)')
    ).toList();
```

## Dynamic Filters

```sql
SELECT Id
FROM Account
WHERE
    Industry = 'IT' AND
    Name = 'My Account' AND
    NumberOfEmployees >= 10
```

```apex
// build conditions on fly
SOSL.FilterGroup group = SOSL.FilterGroup
    .add(SOSL.Filter.name().equal('My Account'))
    .add(SOSL.Filter.with(Account.NumberOfEmployees).greaterOrEqual(10));

SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.Industry).equal('IT'))
        .add(group)
    ).toList();
```
