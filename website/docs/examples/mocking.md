---
sidebar_position: 13
---

# MOCKING

Mock SOSL results in Unit Tests.
Currently you can mock only `search` (`.toSearchList`) queries. Because `.find` (`.toSearchResult`) returns `Search.SearchResult` object which cannot be constructed in apex.

You need to mock external objects.

> In Apex tests, use dynamic SOSL to query external objects. Tests that perform static SOSL queries of external objects fail. ~ Salesforce

## Mock Search results

Firstly, set mocking ID in Query declaration.

```apex
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

Pass list of `List<Sobject>` to SOSL class, and use mock Id to target query to be mocked.

```apex
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

During execution Selector will return record that was set by `.setMock` method.
