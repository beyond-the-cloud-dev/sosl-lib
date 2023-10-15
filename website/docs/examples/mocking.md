---
sidebar_position: 13
---

# MOCKING

Mock SOSL results in Unit Tests. External objects require mocking.

> In Apex tests, use dynamic SOSL to query external objects. Tests that perform static SOSL queries of external objects fail. ~ Salesforce

## Mock without Database insert
Mocking without inserting records to database is only posible using `search` (`.toSearchList`) method. This is caused by return type for `find` which is returning `Search.SearchResults` which cannot be constructed.

1. Set Mock Id in Query declaration
```java
public with sharing class ExampleController {

    public static List<Account> searchAccountsByName(String accountName) {
        return SOSL.find(accountName)
            .inAllFields()
            .returning(
                SOSL.returning(Account.SObjectType)
            )
            .mockId('MockingExample')
            .toSearchList()
            .get(0);
        }
}
```

1. Pass list of `List<Sobject>` to SOSL class, and using `setMock(String mockId, List<List<SObject>> records)` method. Set `mockId` to target query to be mocked.
```java
List<SObject> testAccounts = new List<Account>{ new Account(Name = TEST_ACCOUNT_NAME) };
SOSL.setMock('MockingExample', new List<List<SObject>>{ testAccounts });
```


3. During execution Selector will return record that was set by `.setMock` method.
```java
Assert.areEqual(TEST_ACCOUNT_NAME, result.get(0).Name);
```

4. Full test method:
```java
@IsTest
public class ExampleControllerTest {
    private static final String TEST_ACCOUNT_NAME = 'MyAccount 1';

    @IsTest
    static void getAccountByName() {
        List<SObject> testAccounts = new List<Account>{ new Account(Name = TEST_ACCOUNT_NAME) };
        SOSL.setMock('MockingExample', new List<List<SObject>>{ testAccounts });

        Test.startTest();
        Account result = (Account) ExampleController.searchAccountsByName(TEST_ACCOUNT_NAME);
        Test.stopTest();

        Assert.areEqual(TEST_ACCOUNT_NAME, result.get(0).Name);
    }
}
```

## Mock with database insert
You can mock both `search` and `find` after inserting records into database.

1. Set Mock Id in Query declaration
```java
public with sharing class ExampleController {

    public static List<Account> searchAccountsByName(String accountName) {
        return SOSL.find(accountName)
            .inAllFields()
            .returning(
                SOSL.returning(Account.SObjectType)
            )
            .mockId('MockingExample')
            .toSearchList()
            .get(0);
        }
}
```

2. Inserts records to database and pass `List<Id>` to SOSL class using `setMock(String mockId, List<Id>) records` method. Remember to specify `mockId` to target selected query.
```java
List<Account> testAccounts = new List<Account>{ new Account(Name = SEARCH_TEXT) };
insert testAccounts;

SOSL.setMock('MockingExample', new List<Id>{ testAccounts.get(0).Id });
```

3. During execution Selector will return record that was set by `.setMock` method. It will use standard `Test.setFixedSearchResults` method before return statement.

SOSL Class:
```java
if (mock.hasFixedMock(mockId)) {
    Test.setFixedSearchResults(mock.getFixedMock(mockId));
}
```

Return in test:
```java
 List<List<SObject>> results = SOSL.find(SEARCH_TEXT)
    .inAllFields()
    .returning(SOSL.returning(Account.SObjectType).with(Account.Name))
    .mockId('MockingExample')
    .preview()
    .toSearchList();

List<Account> fixedAccounts = [SELECT Name FROM Account];
Assert.isFalse(results.isEmpty(), 'Should return results for at least one SObject');
Assert.isFalse(results.get(0).isEmpty(), 'Accounts list shouldnt be empty');
Assert.isNotNull(results.get(0).get(0), 'Account should be returned');
Assert.areEqual(((Account) fixedAccounts.get(0)).Name, ((Account) results.get(0).get(0)).Name, 'Accounts name should be equal');
```

4. Full test method:
```java
@IsTest
static void mockFixedIds() {
    // Test
    List<Account> testAccounts = new List<Account>{ new Account(Name = SEARCH_TEXT) };
    insert testAccounts;

    SOSL.setMock('MockingExample', new List<Id>{ testAccounts.get(0).Id });

    List<List<SObject>> results;
    Test.startTest();
    results = SOSL.find(SEARCH_TEXT)
        .inAllFields()
        .returning(SOSL.returning(Account.SObjectType).with(Account.Name))
        .mockId('MockingExample')
        .preview()
        .toSearchList();
    Test.stopTest();

    // Verify
    List<Account> fixedAccounts = [SELECT Name FROM Account];
    Assert.isFalse(results.isEmpty(), 'Should return results for at least one SObject');
    Assert.isFalse(results.get(0).isEmpty(), 'Accounts list shouldnt be empty');
    Assert.isNotNull(results.get(0).get(0), 'Account should be returned');
    Assert.areEqual(((Account) fixedAccounts.get(0)).Name, ((Account) results.get(0).get(0)).Name, 'Accounts name should be equal');
}
```
