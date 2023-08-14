---
sidebar_position: 30
---

# Basic Features

## Dynamic SOSL

The `SOSL.cls` class provides methods for building SOSL clauses dynamically.

```apex
// SELECT Id FROM Account LIMIT 100
SOSL.of(Account.SObjectType)
    .with(Account.Id, Account.Name)
    .setLimit(100)
    .toList();
```

## Control FLS

[AccessLevel Class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_class_System_AccessLevel.htm)

Object permissions and field-level security are controlled by the lib. Developers can change FLS settings to match business requirements.

### User mode

By default, all queries are executed in `AccessLevel.USER_MODE`.

> The object permissions, field-level security, and sharing rules of the current user are enforced.

### System mode

Developers can change the mode to `AccessLevel.SYSTEM_MODE` by using the `.systemMode()` method.

> The object and field-level permissions of the current user are ignored, and the record sharing rules are controlled by the sharingMode.

```apex
// SELECT Id FROM Account - skip FLS
SOSL.of(Account.SObjectType)
    .with(Account.Id, Account.Name)
    .systemMode()
    .toList();
```

## Control Sharings

[Apex Sharing](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_sharing.htm)

> Use the with sharing or without sharing keywords on a class to specify whether sharing rules must be enforced. Use the inherited sharing keyword on a class to run the class in the sharing mode of the class that called it.

### with sharing

By default, all queries are executed `with sharing`, enforced by `AccessLevel.USER_MODE`.

`AccessLevel.USER_MODE` enforces object permissions and field-level security.

Developer can skip FLS by adding `.systemMode()` and `.withSharing()`.

```apex
// Query executed in without sharing
SOSL.of(Account.SObjectType)
    .with(Account.Id, Account.Name)
    .systemMode()
    .withSharing()
    .toList();
```

### without sharing

Developer can control sharing rules by adding `.systemMode()` (record sharing rules are controlled by the sharingMode) and `.withoutSharing()`.

```apex
// Query executed in with sharing
SOSL.of(Account.SObjectType)
    .with(Account.Id, Account.Name)
    .systemMode()
    .withoutSharing()
    .toList();
```

### inherited sharing

Developer can control sharing rules by adding `.systemMode()` (record sharing rules are controlled by the sharingMode) by default it is `inherited sharing`.

```apex
// Query executed in inherited sharing
SOSL.of(Account.SObjectType)
    .with(Account.Id, Account.Name)
    .systemMode()
    .toList();
```

## Mocking

Mocking provides a way to substitute records from a Database with some prepared data. Data can be prepared in form of SObject records and lists in Apex code or Static Resource `.csv` file.
Mocked queries won't make any SOSL's and simply return data set in method definition, mock __will ignore all filters and relations__, what is returned depends __solely on data provided to the method__. Mocking is working __only during test execution__. To mock SOSL query, use `.mockId(id)` method to make it identifiable. If you mark more than one query with the same ID, all marked queries will return the same data.

```apex
public with sharing class ExampleController {

    public static List<Account> getPartnerAccounts(String accountName) {
        return SOQL_Account.query()
            .with(Account.BillingCity, Account.BillingCountry)
            .whereAre(SOSL.FilterGroup
                .add(SOSL.Filter.name().contains(accountName))
                .add(SOSL.Filter.recordType().equal('Partner'))
            )
            .mockId('ExampleController.getPartnerAccounts')
            .toList();
    }
}
```

Then in test simply pass data you want to get from Selector to `SOSL.setMock(id, data)` method. Acceptable formats are: `List<SObject>` or `SObject`. Then during execution Selector will return desired data.

### List of records

```apex
@IsTest
private class ExampleControllerTest {

    @IsTest
    static void getPartnerAccounts() {
        List<Account> accounts = new List<Account>{
            new Account(Name = 'MyAccount 1'),
            new Account(Name = 'MyAccount 2')
        };

        SOSL.setMock('ExampleController.getPartnerAccounts', accounts);

        // Test
        List<Account> result = ExampleController.getPartnerAccounts('MyAccount');

        Assert.areEqual(accounts, result);
    }
}
```

## Dynamic conditions

Build your conditions in a dynamic way.

**Ignore condition**

Ignore condition when logic expression evaluate to true.

```apex
// SELECT Id FROM Account WHERE BillingCity = 'Krakow'

String accountName = '';

SOSL.of(Account.SObjectType)
    .whereAre(SOSL.FilterGroup
        .add(SOSL.Filter.with(Account.BillingCity).equal('Krakow'))
        .add(SOSL.Filter.name().contains(accountName).ignoreWhen(String.isEmpty(accountName)))
    ).toList();
```

**Filter Group**

Create [SOSL.FilterGroup](../api/sosl-filters-group.md) and assign conditions dynamically based on your own criteria.

```apex
public List<Account> getAccounts() {
    SOSL.FilterGroup filterGroup;

    if (UserInfo.getUserType() == 'PowerPartner')
        filterGroup = SOSL.FilterGroup
            .add(SOSL.Filter.with(Account.Name).equal('Test'));
            .add(SOSL.Filter.with(Account.BillingCity).equal('Krakow'));
    } else {
        filterGroup = SOSL.FilterGroup
            .add(SOSL.Filter.with(Account.Name).equal('Other Test'));
    }

    return SOSL.of(Account.SObjectType)
        .whereAre(filterGroup)
        .toList();
}
```
